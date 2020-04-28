import argparse
import time
from tableauhyperapi import Connection
from tableauhyperapi import CreateMode
from tableauhyperapi import HyperProcess
from tableauhyperapi import Telemetry

def load(hyper, dbfile, ddlfile, infile):
    with open(ddlfile) as f:
        ddl = f.read()
        with Connection(hyper.endpoint, dbfile, CreateMode.CREATE) as conn:
            count = conn.execute_command(ddl)
            start = time.time()
            count = conn.execute_command("COPY logs FROM '" + infile + "' WITH (FORMAT csv, HEADER)")
            stop = time.time()
            print('Time:', str(stop - start))

def query(hyper, dbfile, queries):
    for query in queries:
        with open(query) as f:
            sql = f.read()
            with Connection(hyper.endpoint, dbfile) as conn:
                start = time.time()
                with conn.execute_query(sql) as result:
                    stop = time.time()
                    #schema = result.schema()
                    for row in result:
                        print(row)
                    print('Time:', str(stop - start))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('dbfile')
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-l', '--load', nargs=2, metavar=('ddlfile', 'infile'))
    group.add_argument('-q', '--query', nargs='+')
    args = parser.parse_args()

    with HyperProcess(Telemetry.DO_NOT_SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        if args.load is not None:
            load(hyper, args.dbfile, args.load[0], args.load[1])
        elif args.query is not None:
            query(hyper, args.dbfile, args.query)
        else:
            pass

if __name__ == '__main__':
    main()
