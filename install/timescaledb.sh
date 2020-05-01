#!/bin/bash
sudo add-apt-repository ppa:timescale/timescaledb-ppa
sudo apt update
sudo apt install timescaledb-postgresql-12
sudo timescaledb-tune
sudo service postgresql restart
