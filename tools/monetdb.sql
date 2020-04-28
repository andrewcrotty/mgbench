--mclient -u monetdb -d mgbench -t performance
--password: monetdb
COPY 22023859 OFFSET 2 RECORDS INTO logs FROM '/data/agg/ddd/bench1.csv' USING DELIMITERS ',' NULL AS '';
COPY 75748118 OFFSET 2 RECORDS INTO logs FROM '/data/agg/ddd/bench2.csv' USING DELIMITERS ',' NULL AS '';
