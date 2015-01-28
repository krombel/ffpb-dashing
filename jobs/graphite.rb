require 'net/http'
require 'json'
require 'date'
require 'time'

# Pull data from Graphite and make available to Dashing Widgets
# Heavily inspired from Thomas Van Machelen's "Bling dashboard article"
# source: https://gist.github.com/Ulrhol/5088efcc94de2fecad5e
 
# Set the graphite host and port (ip or hostname)
GRAPHITE_HOST = 'graphite.paderborn.freifunk.net'
### inserted following line in /etc/hosts: #######
## fdca:ffee:ff12:a255::da7a graphite.ffpb	##
##################################################
#GRAPHITE_HOST = 'graphite.ffpb'
GRAPHITE_PORT = '80'
INTERVAL = '30s'
 
# Job mappings. Define a name and set the metrics name from graphite
 
job_mappingNotes = {
    'traffic_txbytes' => 'sumSeries(ffpb.gateways.gw01.vpn.txbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.txbytes_per_second%2Cffpb.gateways.gw03.vpn.txbytes_per_second%2Cffpb.gateways.gw04.vpn.txbytes_per_second%2Cffpb.gateways.gw05.vpn.txbytes_per_second%2Cffpb.gateways.gw06.vpn.txbytes_per_second)',
    'traffic_rxbytes' => 'sumSeries(ffpb.gateways.gw01.vpn.rxbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.rxbytes_per_second%2Cffpb.gateways.gw03.vpn.rxbytes_per_second%2Cffpb.gateways.gw04.vpn.rxbytes_per_second%2Cffpb.gateways.gw05.vpn.rxbytes_per_second%2Cffpb.gateways.gw06.vpn.rxbytes_per_second)',
}

Job1 = { aktWidget: 'traffic_sum',
	 maxWidget: "maxTraffic",
	 highscoreFile: "maxTraffic.txt",
	 statname: 'sumSeries(ffpb.gateways.gw01.vpn.txbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.txbytes_per_second%2Cffpb.gateways.gw03.vpn.txbytes_per_second%2Cffpb.gateways.gw04.vpn.txbytes_per_second%2Cffpb.gateways.gw05.vpn.txbytes_per_second%2Cffpb.gateways.gw06.vpn.txbytes_per_second%2Cffpb.gateways.gw01.vpn.rxbytes_per_second%2Cffpb.gateways.gw02.ipv6.txbytes_per_second%2Cffpb.gateways.gw02.vpn.rxbytes_per_second%2Cffpb.gateways.gw03.vpn.rxbytes_per_second%2Cffpb.gateways.gw04.vpn.rxbytes_per_second%2Cffpb.gateways.gw05.vpn.rxbytes_per_second%2Cffpb.gateways.gw06.vpn.rxbytes_per_second)'}
Job2 = { aktWidget: 'ClientCountGraph',
	 maxWidget: "maxClientCount",
	 highscoreFile: "maxClient.txt",
	 statname: 'ffpb.nodes.clients'}
Job3 = { aktWidget: 'NodeCountGraph',
	 maxWidget: "maxNodeCount",
	 highscoreFile: "maxNodes.txt",
	 statname: 'offset(ffpb.nodes.count,6)'}

Jobs = [Job1, Job2, Job3]

class Highscore
	attr_accessor :value
	attr_accessor :time
	def initialize (file)
		@file = file
		@value = 1
		@time = 1
		if File.exists?(file)
			maxFile = File.open(@file, "r")
			@value = maxFile.readline.to_i
			@time = maxFile.readline.to_i
			maxFile.close
		end
	end

	def checkAndSet (value, time)
		if @value < value
			@value = value
			@time = time
			maxFile = File.new(@file, "w")
			maxFile.puts(value)
			maxFile.puts(time)
			maxFile.close
		end
	end
end

# Extend the float to allow better rounding. Too many digits makes a messy dashboard
class Float
    def sigfig_to_s(digits)
        f = sprintf("%.#{digits - 1}e", self).to_f
        i = f.to_i
        (i == f ? i : f)
    end
end

class Graphite
    # Initialize the class
    def initialize(host, port)
        @host = host
        @port = port
    end

    # Use Graphite api to query for the stats, parse the returned JSON and return the result
    def query(statname, since=nil)
        since ||= '1h-ago'
        http = Net::HTTP.new(@host, @port)
        response = http.request(Net::HTTP::Get.new("/render?format=json&target=#{statname}&from=#{since}"))
        result = JSON.parse(response.body, :symbolize_names => true)
        return result.first
    end

    # Gather the datapoints and turn into Dashing graph widget format
    def points(name, highscore, since=nil)
        since ||= '-24hours'
        stats = query name, since
        datapoints = stats[:datapoints]
 
        points = []
        count = 1
 
        (datapoints.select { |el| not el[0].nil? }).each do|item|
            aktValue = self.get_value(item)
            highscore.checkAndSet aktValue, Time.now.to_i
            points << { x: count, y: aktValue}
            count += 1
        end

        value = (datapoints.select { |el| not el[0].nil? }).last[0].to_s
 
        return points, value
    end

    def get_value(datapoint)
        value = datapoint[0] || 0
        return value.round(2)
    end
 
    def value(name, since=nil)
        since ||= '-10min'
        stats = query name, since
        last = (stats[:datapoints].select { |el| not el[0].nil? }).last[0].sigfig_to_s(2)
 
        return last
    end

end

Jobs.each do |job|
   SCHEDULER.every INTERVAL, :first_in => 0 do
        # Create an instance of our Graphite class
        q = Graphite.new GRAPHITE_HOST, GRAPHITE_PORT

	highscore = Highscore.new job.fetch(:highscoreFile)
        # Get the current points and value. Timespan is static atm
        points, current = q.points job.fetch(:statname) , highscore

        # Send to dashboard, tested supports for number, meter and graph widgets
        send_event job.fetch(:aktWidget), { current: current, value: current, points: points }
        # Send highscore to dashboard
        send_event job.fetch(:maxWidget), { current: highscore.value , archievedAt: highscore.time }
   end
end
