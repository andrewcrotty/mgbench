--sudo su - postgres
--psql

--load
COPY logs FROM '/home/ubuntu/bench1.csv' WITH (FORMAT csv, HEADER);
COPY logs FROM '/home/ubuntu/bench2.csv' WITH (FORMAT csv, HEADER);
COPY logs FROM '/home/ubuntu/bench3.csv' WITH (FORMAT csv, HEADER);


monetdb create mgbench

--mclient -u monetdb -d mgbench -t performance
--password: monetdb

--load
COPY 22023859 OFFSET 2 RECORDS INTO logs FROM '/path/to/bench1.csv' USING DELIMITERS ',' NULL AS '';
COPY 75748118 OFFSET 2 RECORDS INTO logs FROM '/path/to/bench2.csv' USING DELIMITERS ',' NULL AS '';
COPY 109436423 OFFSET 2 RECORDS INTO logs FROM '/path/to/bench3.csv' USING DELIMITERS ',' NULL AS '';
