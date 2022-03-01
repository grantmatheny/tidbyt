#!/bin/bash

cd ~

wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
rm go1.17.7.linux-amd64.tar.gz
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"


apt update
apt install git libwebp-dev nodejs -y


#git clone https://github.com/grantmatheny/tidbyt.git
git clone https://github.com/tidbyt/pixlet
cd pixlet
npm install
npm run build
make build

