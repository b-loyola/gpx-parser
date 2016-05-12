require 'nokogiri'
require 'open-uri'
# require 'byebug'

class Parser

	def self.wrong_number_args?(args_array)
		args_array.size != 1
	end

	def initialize(source)
		@source = source
	end

	def extract_coordinates(gpx_source)
		waypoints = []
		gpx_source.css("trkpt").each do |waypoint|
			coords = []
			coords << waypoint.attribute("lat").value
			coords << waypoint.attribute("lon").value
			waypoints << coords
		end
		waypoints
	end

	# Returns array of coordinates
	def parse
		gpx_source = Nokogiri::HTML(open(@source))
		extract_coordinates(gpx_source)
	end

end

if Parser.wrong_number_args?(ARGV)
	puts "wrong number of arguments"
	puts "correct usage: ruby gpx_parser.rb http://www.example.com"
else
	parser = Parser.new(ARGV[0])
	coordinates = parser.parse

	coordinates.each do |pair|
		puts "Coords: #{pair}"
	end
end