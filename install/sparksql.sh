#!/bin/bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jre-headless python3.7 python3-pip
python3.7 -m pip install pyspark
#python3.7 -m pip install prompt_toolkit
#python3.7 -m pip install tableauhyperapi
#python3.7 -m pip install pygments
