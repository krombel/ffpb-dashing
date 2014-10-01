# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
#require 'open-uri'

aktClientCount = 0
aktNodeCount = 0
maxClientCount = 521
maxNodeCount = 347

lastAktValueChanged = 42 # unimportant, which value
lastMaxNodeCountDate = 0
lastMaxClientCountDate = 0

SCHEDULER.every '5s', :first_in => 0 do
	# update as fast as possible after the update of the counts-Skript. And then wait for the next value.
 aktValueChanged = open('../freifunk-counts/changevalue.txt') { |f| f.read }
 if lastAktValueChanged != aktValueChanged
  aktClientCount2 = aktClientCount
  aktNodeCount2 = aktNodeCount
 
  aktNodeCount = open('../freifunk-counts/Nodecount/aktNodecount.txt') { |f| f.read }
  aktClientCount = open('../freifunk-counts/Clientcount/aktClientcount.txt') { |f| f.read }

  # only show the difference in percent, if the value has changed
  if aktClientCount2 == aktClientCount
  	send_event('aktClientCount', { current: aktClientCount})
  else
  	send_event('aktClientCount', { current: aktClientCount, last: aktClientCount2 })
  end
  
  if aktNodeCount2 == aktNodeCount
  	send_event('aktNodeCount', { current: aktNodeCount})
  else
  	send_event('aktNodeCount', { current: aktNodeCount, last: aktNodeCount2 })
  end
  lastAktValueChanged = aktValueChanged
 end # if aktValueChanged
 
 maxNodeCountDate = open('../freifunk-counts/Nodecount/maxNodecount.date.txt') { |f| f.read }
 if lastMaxNodeCountDate != maxNodeCountDate
  maxNodeCount = open('../freifunk-counts/Nodecount/maxNodecount.txt') { |f| f.read }
  send_event('maxNodeCount', { current: maxNodeCount, archievedAt: maxNodeCountDate })
  lastMaxNodeCountDate = maxNodeCountDate
 end # if maxNodeCount changed 
 
 maxClientCountDate = open('../freifunk-counts/Clientcount/maxClientcount.date.txt') { |f| f.read }
 if lastMaxClientCountDate != maxClientCountDate
  maxClientCount = open('../freifunk-counts/Clientcount/maxClientcount.txt') { |f| f.read }
  send_event('maxClientCount', { current: maxClientCount, archievedAt: maxClientCountDate })
  lastMaxClientCountDate = maxClientCountDate
 end # if maxClientCount changed
end

#require 'open-uri'
#file_contents = open('local-file.txt') { |f| f.read }
#web_contents  = open('http://www.stackoverflow.com') {|f| f.read }
