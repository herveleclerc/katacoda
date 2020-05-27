#!/bin/bash

echo "export PATH=\$PATH:\$HOME/go/bin" >> "$HOME/.bashrc"
echo "export PATH=\$PATH:\$HOME/bin" >> "$HOME/.bashrc"

source "$HOME/.bashrc"

mkdir -p ~/templates/default
mkdir -p ~/templates/dev
mkdir -p ~/templates/qa
mkdir -p ~/templates/prod

 wait.sh