import argparse
import json
import requests
import time
from prompt_toolkit import PromptSession
from prompt_toolkit.completion import WordCompleter
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import Style
from pygments.lexers.sql import SqlLexer
#from pyspark.sql import SparkSession
from tableauhyperapi import Connection
from tableauhyperapi import CreateMode
from tableauhyperapi import HyperProcess
from tableauhyperapi import Telemetry

"""
style = Style.from_dict({
    'completion-menu.completion': 'bg:#008888 #ffffff',
    'completion-menu.completion.current': 'bg:#00aaaa #000000',
    'scrollbar.background': 'bg:#88aaaa',
    'scrollbar.button': 'bg:#222222',
})
"""

class System:
    def create(self, ddl):
        raise NotImplementedError

    def load(self, filename):
        raise NotImplementedError

    def query(self, sql):
        raise NotImplementedError


class Druid(System):
    LOAD_URL = 'http://localhost:8081/druid/indexer/v1/task'
    QUERY_URL = 'http://localhost:8888/druid/v2/sql'

    def __init__(self):
        self.parallel = 48
        self.index = True
        self.bitmap = 'concise' #concise, roaring
        self.compress = 'uncompressed' #uncompressed, lz4, lzf
        self.encode = 'longs' #longs, auto
        self.schema = None

    def create(self, ddl):
        self.schema = json.loads(ddl)
        return []

    def load(self, filename):
        dir, filter = filename.rsplit('/', 1)
        spec = {
            'type': 'index_parallel',
            'spec': {
                'dataSchema': {
                    'dataSource': 'logs',
                    'timestampSpec': {
                        'column': 'log_time'
                    },
                    'dimensionsSpec': {
                        'dimensions': self.schema['dimensions']
                    },
                    'metricsSpec': [],
                    'granularitySpec': {
                        'rollup': 'false',
                        'intervals': self.schema['intervals']
                    }
                },
                'ioConfig': {
                    'type': 'index_parallel',
                    'inputSource': {
                        'type': 'local',
                        'baseDir': dir + '/',
                        'filter': filter
                    },
                    'inputFormat': {
                        'type': 'csv',
                        'findColumnsFromHeader': True
                    }
                },
                'tuningConfig': {
                    'type': 'index_parallel',
                    'maxRowsInMemory': 100000000,
                    'maxNumConcurrentSubTasks': self.parallel,
                    'indexSpec': {
                        'bitmap': {'type': self.bitmap},
                        'dimensionCompression': self.compress,
                        'longEncoding': self.encode
                    }
                }
            }
        }
        print(json.dumps(self.spec))
        response = requests.post(Druid.LOAD_URL, json=self.spec)
        print(json.dumps(response.json()))
        return []

    def query(self, sql):
        query = {
            'query': sql,
            'context': {
                'useCache': False,
                'populateCache': False,
                'useResultLevelCache': False,
                'populateResultLevelCache': False,
                'vectorize': True
            }
        }
        print(json.dumps(query))
        response = requests.post(Druid.QUERY_URL, json=query)
        print(json.dumps(response.json()))
        return response


class Hyper(System):
    def __init__(self, filename):
        self.db = HyperProcess(Telemetry.DO_NOT_SEND_USAGE_DATA_TO_TABLEAU)
        self.conn = Connection(self.db.endpoint, filename, CreateMode.CREATE)

    def create(self, ddl):
        count = self.conn.execute_command(ddl)
        return [count]

    def load(self, filename):
        count = self.conn.execute_command("COPY logs FROM '" + filename + "' WITH (FORMAT csv, HEADER)")
        return [count]

    def query(self, sql):
        #schema = result.schema()
        return self.conn.execute_query(sql)


class SparkSQL(System):
    def __init__(self):
        self.spark = SparkSession.builder.master('local[48]').getOrCreate()
        self.schema = None
        #self.ts_fmt = 'yyyy-MM-dd HH:mm:ss'

    def create(self, ddl):
        self.schema = sql.split('(')[1].split(')')[0].replace('\n', '')
        return []

    def load(self, filename):
        df = self.spark.read.csv(filename, schema=self.ddl, header=True)
        df.createOrReplaceTempView('logs')
        self.spark.catalog.cacheTable('logs')
        count = self.spark.sql('SELECT COUNT(*) FROM logs').collect()
        return [count]

    def query(self, sql):
        result = self.spark.sql(sql).collect()
        return result


def run(cmd):
    start = time.time()
    rows = [row for row in cmd()]
    stop = time.time()
    for row in rows:
        print(row)
    print('Time:', str(stop - start))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('system', choices=['druid','hyper','sparksql'])
    args = parser.parse_args()

    if args.system == 'druid':
        system = Druid()
    elif args.system == 'hyper':
        system = Hyper('db.hyper')
    elif args.system == 'sparksql':
        system = SparkSQL()

    session = PromptSession(lexer=PygmentsLexer(SqlLexer))
    while True:
        try:
            input = session.prompt('mgbench> ').strip()
            if input[:4].lower() == 'load':
                run(lambda: system.load(input.split()[1]))
            else:
                if input[:3].lower() == 'run':
                    with open(input.split()[1]) as f:
                        sql = f.read()
                else:
                    sql = input
                sql = sql.strip().replace(';', '')

                if sql[:6].lower() == 'create' or input.split()[1][-4:] == 'json':
                    run(lambda: system.create(sql))
                else:
                    run(lambda: system.query(sql))
        except KeyboardInterrupt:
            continue
        except EOFError:
            break
        except Exception as e:
            print(e)


if __name__ == '__main__':
    main()
