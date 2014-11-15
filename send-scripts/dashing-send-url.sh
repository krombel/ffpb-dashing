#!/bin/sh
. ./loadServerdata.sh

metric=$1
url=$2

info="{ \"auth_token\": \"$auth_token\", \"url\": \"$url\" }"

curl -d "$info" http://$host/widgets/$metric

