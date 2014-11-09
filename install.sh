#!/bin/bash
# This skript installs all depencies and starts dashing
dashing_dir=~/freifunk-dashing

sudo apt-get update
sudo apt-get install ruby1.9.1 ruby1.9.1-dev make g++ bundler
sudo gem install dashing

git clone git://git.krombel.de/freifunk-dashing $dashing_dir

cd $dashing_dir
bundle
dashing start
