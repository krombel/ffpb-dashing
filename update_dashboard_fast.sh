#/bin/sh
host="dashing.krombel.de:3030"
auth_token="bitnhmlj47hamrftxkiug"

aktNodeCount=$1
aktNodeCount_prev=$2
aktClientCount=$3
aktClientCount_prev=$4
maxNodeCount=$5
maxClientCount=$6

trafficpoints="[
{\"x\":${7},\"y\":${8}},
{\"x\":${9},\"y\":${10} },
{\"x\":${11},\"y\":${12} },
{\"x\":${13},\"y\":${14} },
{\"x\":${15},\"y\":${16} },
{\"x\":${17},\"y\":${18} },
{\"x\":${19},\"y\":${20} },
{\"x\":${21},\"y\":${22} },
{\"x\":${23},\"y\":${24} },
{\"x\":${25},\"y\":${26} }]"
traffic_akt=${27}

curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$aktNodeCount\", \"last\": \"$aktNodeCount_prev\" }" \
	\http://$host/widgets/aktNodeCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$aktClientCount\", \"last\": \"$aktClientCount_prev\" }" \
	\http://$host/widgets/aktClientCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$maxNodeCount\"}" \
	\http://$host/widgets/maxNodeCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$maxClientCount\"}" \
	\http://$host/widgets/maxClientCount
curl -d "{ \"auth_token\": \"$auth_token\", \"points\": $trafficpoints , \"displayedValue\":\"$traffic_akt\"}" \
	\http://$host/widgets/aktTraffic
