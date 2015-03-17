#!/bin/bash
# This skript installs all depencies and starts dashing
dashing_dir=~/freifunk-dashing

sudo apt-get update
sudo apt-get install ruby1.9.1 ruby1.9.1-dev make g++ bundler
sudo gem install dashing

git clone https://github.com/krombel/ffpb-dashing.git

cd $dashing_dir
bundle
dashing start

## alternatively:
#port=3030
#log=~/dashing.log
#pid=~/dashing.pid
#/usr/local/bin/thin -R config.ru start -p $port --daemonize -l $log --pid $pid

