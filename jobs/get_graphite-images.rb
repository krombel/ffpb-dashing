# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
#require 'open-uri'
# require "freifunk-counts" running and located in $dashing-home/../freifunk-counts/

# How to read stuff outside of our dashboard
#require 'open-uri'
#file_contents = open('local-file.txt') { |f| f.read }
#web_contents  = open('http://www.stackoverflow.com') {|f| f.read }

#SCHEDULER.every '15m', :first_in => 0 do

# download graph for Client/Nodecount
#  usageURL='http://graphite.paderborn.freifunk.net/render?width=270&from=-24hours&until=now&height=340&target=alias(ffpb.nodes.clients%2C%22Clients%22)&target=alias(ffpb.nodes.count%2C%22Nodes%22)&title=Nutzer%20%2F%20Knoten%20im%20Freifunk-Netz'
#  open('assets/images/aktUsageGraph.png', 'wb') do |file|
#    file << open(usageURL).read
#  end

# download graph for Gateway-Traffic
#  trafficURL='http://graphite.paderborn.freifunk.net/render?width=270&from=-24hours&until=now&height=340&target=alias(sumSeries(ffpb.gateways.gw01.vpn.rxbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.rxbytes_per_second%2Cffpb.gateways.gw03.vpn.rxbytes_per_second%2Cffpb.gateways.gw04.vpn.rxbytes_per_second%2Cffpb.gateways.gw05.vpn.rxbytes_per_second%2Cffpb.gateways.gw06.vpn.rxbytes_per_second)%2C%22Empfangen%22)&target=alias(sumSeries(ffpb.gateways.gw01.vpn.txbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.txbytes_per_second%2Cffpb.gateways.gw03.vpn.txbytes_per_second%2Cffpb.gateways.gw04.vpn.txbytes_per_second%2Cffpb.gateways.gw05.vpn.txbytes_per_second%2Cffpb.gateways.gw06.vpn.txbytes_per_second)%2C%22Gesendet%22)&title=Bytes%20%2F%20s%20ueber%20alle%20Gateways'
#  open('assets/images/aktTrafficGraph.png', 'wb') do |file|
#    file << open(trafficURL).read
#  end

# notify dashboard to reload this images
#  send_event('TrafficFrame', { url: trafficURL })
#  send_event('ClientNodecountFrame', { url: usageURL })
#  send_event('TrafficFrame', { url: '/assets/aktUsageGraph.png' })
#  send_event('ClientNodecountFrame', { url: '/assets/aktTrafficGraph.png' })
#  send_event('TrafficFrame', { url: '/assets/aktTrafficGraph.png' })
#  send_event('ClientNodecountFrame', { url: '/assets/aktUsageGraph.png' })
#end
