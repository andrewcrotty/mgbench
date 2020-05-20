import argparse
import json
import requests
import sys
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

#cmds = WordCompleter(['load', 'run'])

"""
style = Style.from_dict({
    'completion-menu.completion': 'bg:#008888 #ffffff',
    'completion-menu.completion.current': 'bg:#00aaaa #000000',
    'scrollbar.background': 'bg:#88aaaa',
    'scrollbar.button': 'bg:#222222',
})
"""


class System:
    def create(self, sql):
        raise NotImplementedError

    def load(self, filename):
        raise NotImplementedError

    def query(self, sql):
        raise NotImplementedError


class Druid(System):
    def __init__(self):
        self.parallel = 48
        self.index = True
        self.bitmap = 'concise' #concise, roaring
        self.compress = 'uncompressed' #uncompressed, lz4, lzf
        self.encode = 'longs' #longs, auto

    def create(self, sql):
        self.ddl = [
            {'name': 'machine_name', 'createBitmapIndex': self.index},
            {'name': 'machine_group', 'createBitmapIndex': self.index},
            {'name': 'cpu_idle', 'type': 'float'},
            {'name': 'cpu_nice', 'type': 'float'},
            {'name': 'cpu_system', 'type': 'float'},
            {'name': 'cpu_user', 'type': 'float'},
            {'name': 'cpu_wio', 'type': 'float'},
            {'name': 'disk_free', 'type': 'float'},
            {'name': 'disk_total', 'type': 'float'},
            {'name': 'part_max_used', 'type': 'float'},
            {'name': 'load_fifteen', 'type': 'float'},
            {'name': 'load_five', 'type': 'float'},
            {'name': 'load_one', 'type': 'float'},
            {'name': 'mem_buffers', 'type': 'float'},
            {'name': 'mem_cached', 'type': 'float'},
            {'name': 'mem_free', 'type': 'float'},
            {'name': 'mem_shared', 'type': 'float'},
            {'name': 'swap_free', 'type': 'float'},
            {'name': 'bytes_in', 'type': 'float'},
            {'name': 'bytes_out', 'type': 'float'}
        ]
        """
        {'name': 'client_ip', 'createBitmapIndex': index},
        {'name': 'request', 'createBitmapIndex': index},
        {'name': 'status_code', 'type': 'long'},
        {'name': 'object_size', 'type': 'long'}
        """
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
                        'dimensions': self.ddl
                    },
                    'metricsSpec': [],
                    'granularitySpec': {
                        'rollup': 'false',
                        'intervals': [
                            '2016-11-01/2017-01-12'
                        ]
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
        print(json.dumps(spec))
        response = requests.post('http://localhost:8081/druid/indexer/v1/task', json=spec)
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
        response = requests.post('http://localhost:8888/druid/v2/sql', json=query)
        print(json.dumps(response.json()))
        return response


class Hyper(System):
    def __init__(self, filename):
        self.db = HyperProcess(Telemetry.DO_NOT_SEND_USAGE_DATA_TO_TABLEAU)
        self.conn = Connection(self.db.endpoint, filename, CreateMode.CREATE)

    def create(self, sql):
        count = self.conn.execute_command(sql)
        return [count]

    def load(self, fname):
        count = self.conn.execute_command("COPY logs FROM '" + fname + "' WITH (FORMAT csv, HEADER)")
        return [count]

    def query(self, sql):
        #schema = result.schema()
        return self.conn.execute_query(sql)


class SparkSQL(System):
    def __init__(self):
        self.spark = SparkSession.builder.master('local[48]').getOrCreate()
        self.ddl = None
        self.ts_fmt = 'yyyy-MM-dd HH:mm:ss'

    def create(self, sql):
        self.ddl = sql.split('(')[1].split(')')[0].replace('\n', '')
        return []

    def load(self, filename):
        self.spark.read.csv(filename, schema=self.ddl, header=True,
                timestampFormat=self.ts_fmt).createOrReplaceTempView('logs')
        count = self.spark.sql('SELECT COUNT(*) FROM logs').collect()
        return [count]

    def query(self, sql):
        result = self.spark.sql(sql).collect()
        return result


def run(cmd):
    start = time.time()
    result = cmd()
    stop = time.time()
    for row in result:
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

                if sql[:6].lower() == 'create':
                    run(lambda: system.create(sql))
                else:
                    run(lambda: system.query(sql))
        except KeyboardInterrupt:
            continue
        except EOFError:
            break
        except:
            print(sys.exc_info()[0])


if __name__ == '__main__':
    main()
