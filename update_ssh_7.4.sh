#!/bin/bash

sudo apt install -y build-essential libssl-dev zlib1g-dev
wget "http://mirrors.evowise.com/pub/OpenBSD/OpenSSH/portable/openssh-7.4p1.tar.gz"
tar xfz openssh-7.4p1.tar.gz
cd openssh-7.4p1
./configure
make
sudo make install

ssh -V
