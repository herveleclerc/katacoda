#!/bin/bash

sleep 15

echo "done" >> /root/katacoda-finished

echo "tasks"
curl -sL https://taskfile.dev/install.sh -o install.sh
bash install.sh

echo "jb"
GO111MODULE="on" go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb

echo "Tanka"
curl -Ls -o "$HOME/go/bin/tk" https://github.com/grafana/tanka/releases/download/v0.10.0/tk-linux-amd64
chmod a+rx "$HOME/go/bin/tk"

echo "jsonnet"
go get github.com/google/go-jsonnet/cmd/jsonnet

echo "Installing packages"
echo "Sponge"
#apt-get  autoremove -qy || echo "OK"
apt-get install -qy moreutils gettext || echo "Done"

echo "ready to go !!!"

echo "done" >> /root/katacoda-background-finished
