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
{\"x\":0,\"y\":${7} },
{\"x\":1,\"y\":${8} },
{\"x\":2,\"y\":${9} },
{\"x\":3,\"y\":${10} },
{\"x\":4,\"y\":${11} },
{\"x\":5,\"y\":${12} },
{\"x\":6,\"y\":${13} },
{\"x\":7,\"y\":${14} },
{\"x\":8,\"y\":${15} },
{\"x\":9,\"y\":${16} }]"

uniqueClientsPoints="[
{\"x\":0,\"y\":${17} },
{\"x\":1,\"y\":${18} },
{\"x\":2,\"y\":${19} },
{\"x\":3,\"y\":${20} },
{\"x\":4,\"y\":${21} },
{\"x\":5,\"y\":${22} },
{\"x\":6,\"y\":${23} },
{\"x\":7,\"y\":${24} },
{\"x\":8,\"y\":${25} },
{\"x\":9,\"y\":${26} }]"

curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$aktNodeCount\", \"last\": \"$aktNodeCount_prev\" }" \
	\http://$host/widgets/aktNodeCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$aktClientCount\", \"last\": \"$aktClientCount_prev\" }" \
	\http://$host/widgets/aktClientCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$maxNodeCount\"}" \
	\http://$host/widgets/maxNodeCount
curl -d "{ \"auth_token\": \"$auth_token\", \"current\": \"$maxClientCount\"}" \
	\http://$host/widgets/maxClientCount
curl -d "{ \"auth_token\": \"$auth_token\", \"points\": $trafficpoints }" \
	\http://$host/widgets/aktTraffic
curl -d "{ \"auth_token\": \"$auth_token\", \"points\": $uniqueClientsPoints }" \
	\http://$host/widgets/uniqueClientCount

#nodes="[
#{\"label\":\"${26}\", \"value\":\"${33}\"},
#{\"label\":\"${27}\", \"value\":\"${34}\"},
#{\"label\":\"${28}\", \"value\":\"${35}\"},
#{\"label\":\"${29}\", \"value\":\"${36}\"},
#{\"label\":\"${30}\", \"value\":\"${37}\"},
#{\"label\":\"${31}\", \"value\":\"${38}\"},
#{\"label\":\"${32}\", \"value\":\"${39}\"}]"
#
#curl -d "{ \"auth_token\": \"$auth_token\", \"items\": `echo $nodes` }" \
#	\http://$host/widgets/lastNodes
