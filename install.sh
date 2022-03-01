#!/bin/bash

cd ~

#wget https://go.dev/dl/go1.17.7.linux-arm64.tar.gz
#tar -C /usr/local -xzf go1.17.7.linux-arm64.tar.gz
#rm go1.17.7.linux-amd64.tar.gz
#export PATH="$PATH:/usr/local/go/bin"
#export GOPATH="$HOME/go"


apt update
apt install git libwebp-dev nodejs npm -y
wget https://github.com/tidbyt/pixlet/releases/download/v0.16.4/pixlet_0.16.4_linux_arm64.tar.gz
tar -C /usr/local/bin -xzf pixlet_0.16.4_linux_arm64.tar.gz


#git clone https://github.com/grantmatheny/tidbyt.git
#git clone https://github.com/tidbyt/pixlet
#cd pixlet
#npm install
#npm run build
#make build

