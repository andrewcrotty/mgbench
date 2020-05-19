#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jre-headless
curl -o crash https://cdn.crate.io/downloads/releases/crash_standalone_latest
chmod +x crash
bash -c "$(curl -L https://try.crate.io/)"
#./crash

#sed -i '2,$s/./T/11' benchX.csv
#export CRATE_HEAP_SIZE=30500m
#export _JAVA_OPTIONS="-Xmx30500m"
