#!/bin/bash

host="localhost:3030"
auth_token="bitnhmlj47hamrftxkiug"

metric=$1
shift
traffic_akt=$1
shift

points="["
while (( "$#" )); do
	x=$1;shift
	y=$1;shift

	points="${points}{ \"x\": $x, \"y\": $y }"
	if (( "$#" )); then
		points="${points}, "
	fi
done
points="${points}]"

info="{ \"auth_token\": \"$auth_token\", \"points\": $points , \"displayedValue\":\"$traffic_akt\"}"
echo $info
curl -d "$info" http://$host/widgets/$metric
