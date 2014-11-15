#!/bin/bash

. ./loadServerdata.sh

metric=$1
shift

items="["
while (( "$#" )); do
	x=$1;shift
	y=$1;shift

	items="${items}{ \"label\": \"$x\", \"value\": \"$y\" }"
	if (( "$#" )); then
		items="${items}, "
	fi
done
items="${items}]"

info="{ \"auth_token\": \"$auth_token\", \"items\": $items }"
echo $info
curl -d "$info" http://$host/widgets/$metric
