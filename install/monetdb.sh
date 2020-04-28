#!/bin/bash
echo "deb https://dev.monetdb.org/downloads/deb/ $(lsb_release -cs) monetdb" | sudo tee -a /etc/apt/sources.list.d/monetdb.list
wget --output-document=- https://www.monetdb.org/downloads/MonetDB-GPG-KEY | sudo apt-key add -
sudo apt update
sudo apt install -y monetdb5-sql monetdb-client
sudo systemctl enable monetdbd
sudo systemctl start monetdbd
