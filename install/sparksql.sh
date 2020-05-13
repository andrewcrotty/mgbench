#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
wget --trust-server-names "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz"
tar -xzvf spark-2.4.5-bin-hadoop2.7.tgz
