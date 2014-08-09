#!/bin/sh

host="dashing.krombel.de:3030"
auth_token="bitnhmlj47hamrftxkiug"

metric=$1
current=$2
previous=$3

info="{ \"auth_token\": \"$auth_token\", \"current\": \"$current\", \"last\": \"$previous\" }"

curl -d "$info" http://$host/widgets/$metric

