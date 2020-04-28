--mclient -u monetdb -d mgbench -t performance
--password: monetdb

--load
COPY 22023859 OFFSET 2 RECORDS INTO logs FROM '/path/to/bench1.csv' USING DELIMITERS ',' NULL AS '';
COPY 75748118 OFFSET 2 RECORDS INTO logs FROM '/path/to/bench2.csv' USING DELIMITERS ',' NULL AS '';
