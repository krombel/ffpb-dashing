#!/bin/bash

dashing_dir=~/freifunk-dashing

apt-get update

sudo apt-get install ruby1.9.1 ruby1.9.1-dev make g++ bundler
cd $dashing_dir

sudo gem install dashing

bundle

dashing start
