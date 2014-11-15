#!/bin/sh
. ./loadServerdata.sh

metric=$1
current=$2
previous=$3

info="{ \"auth_token\": \"$auth_token\", \"current\": \"$current\", \"last\": \"$previous\" }"

curl -d "$info" http://$host/widgets/$metric

