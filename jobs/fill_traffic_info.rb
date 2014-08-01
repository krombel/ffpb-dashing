# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

#points = []
#(1..10).each do |i|
#  points << { x: i, y: rand(50) }
#end
#last_x = points.last[:x]
#
#SCHEDULER.every '2s' do  
#  points.shift
#  last_x += 1
#  points << { x: last_x, y: rand(50)+100 }
#
#  send_event('aktTraffic', points: points)
#end

#current_traffic = 0

#SCHEDULER.every '3s', :first_in => 0 do |job|
#  last_traffic = current_traffic
#  current_traffic = rand(1000)
#
#  send_event('aktTraffic', { current: current_traffic, last: last_traffic })
#end
