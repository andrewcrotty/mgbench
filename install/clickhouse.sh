#!/bin/bash
curl https://clickhouse.com/ | sh
sudo ./clickhouse install --noninteractive
sudo clickhouse start
#clickhouse-client
