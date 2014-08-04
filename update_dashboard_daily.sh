#/bin/sh
host="dashing.krombel.de:3030"
auth_token="bitnhmlj47hamrftxkiug"

# {"x": Zeit im Unix-Format,"y":Anzahl},
uniqueClientsPoints="[
{\"x\":${1},\"y\":${2} },
{\"x\":${3},\"y\":${4} },
{\"x\":${5},\"y\":${6} },
{\"x\":${7},\"y\":${8} },
{\"x\":${9},\"y\":${10} },
{\"x\":${11},\"y\":${12} },
{\"x\":${13},\"y\":${14} },
{\"x\":${15},\"y\":${16} },
{\"x\":${17},\"y\":${18} },
{\"x\":${19},\"y\":${20} }]"

curl -d "{ \"auth_token\": \"$auth_token\", \"points\": $uniqueClientsPoints }" \
	\http://$host/widgets/uniqueClientCount
	
# {"label":"Knotenname", "value":"z.B. Datum des ersten Auftreten"}
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
