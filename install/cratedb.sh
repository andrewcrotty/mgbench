#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
bash -c "$(curl -L https://try.crate.io/)"
curl -o crash https://cdn.crate.io/downloads/releases/crash_standalone_latest
chmod +x crash
#./crash
