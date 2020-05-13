#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk
curl -o crash https://cdn.crate.io/downloads/releases/crash_standalone_latest
chmod +x crash
bash -c "$(curl -L https://try.crate.io/)"
#./crash
