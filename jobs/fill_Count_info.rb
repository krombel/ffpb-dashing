# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
#require 'open-uri'

aktClientCount = 0
aktNodeCount = 0
maxClientCount = 521
maxNodeCount = 347
mychanged = 42 # unimportant, which value

SCHEDULER.every '5s', :first_in => 0 do
	# update as fast as possible after the update of the counts-Skript. And then wait for the next value.
 changedfile = open('../freifunk/changevalue.txt') { |f| f.read }
 if mychanged != changedfile
  aktClientCount2 = aktClientCount
  aktNodeCount2 = aktNodeCount
 
  aktNodeCount = open('../freifunk/Nodecount/aktNodecount.txt') { |f| f.read }
  maxNodeCount = open('../freifunk/Nodecount/maxNodecount.txt') { |f| f.read }
  aktClientCount = open('../freifunk/Clientcount/aktClientcount.txt') { |f| f.read }
  maxClientCount = open('../freifunk/Clientcount/maxClientcount.txt') { |f| f.read }

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
  
  send_event('maxClientCount', { current: maxClientCount})
  send_event('maxNodeCount', { current: maxNodeCount})
  mychanged = changedfile
 end
end

#require 'open-uri'
#file_contents = open('local-file.txt') { |f| f.read }
#web_contents  = open('http://www.stackoverflow.com') {|f| f.read }
