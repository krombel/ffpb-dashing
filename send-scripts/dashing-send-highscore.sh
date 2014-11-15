#!/bin/sh
. ./loadServerdata.sh

metric=$1
current=$2
date=$3

info="{ \"auth_token\": \"$auth_token\", \"current\": \"$current\", \"archievedAt\": \"$date\" }"

curl -d "$info" http://$host/widgets/$metric

