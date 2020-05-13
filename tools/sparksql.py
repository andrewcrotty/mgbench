import argparse
import time
from pyspark.sql import SparkSession

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    parser.add_argument('-q', '--query', nargs='+')
    args = parser.parse_args()

    spark = SparkSession.builder.appName('mgbench').getOrCreate()

    start = time.time()
    df = spark.read.csv(args.filename, inferSchema=True)
    df.createOrReplaceTempView(logs)
    stop = time.time()
    print('Load time:', str(stop - start))

    for query in args.query:
        with open(query) as f:
            sql = f.read()
            start = time.time()
            result = spark.sql(sql)
            stop = time.time()
            print(result)
            print('Time:', str(stop - start))

if __name__ == '__main__':
    main()
