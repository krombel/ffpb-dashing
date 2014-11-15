#!/bin/sh

host="dashing.krombel.de:3030"
auth_token="bitnhmlj47hamrftxkiug"

metric=$1
url=$2

info="{ \"auth_token\": \"$auth_token\", \"url\": \"$url\" }"

curl -d "$info" http://$host/widgets/$metric

