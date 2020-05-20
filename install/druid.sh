#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
wget --trust-server-names "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=druid/0.18.0/apache-druid-0.18.0-bin.tar.gz"
tar -xzf apache-druid-0.18.0-bin.tar.gz
cd apache-druid-0.18.0
#./bin/start-single-server-xlarge
