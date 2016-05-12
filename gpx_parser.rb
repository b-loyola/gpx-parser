require 'nokogiri'
require 'open-uri'
# require 'byebug'
require 'awesome_print'

class GpxParser

	def self.wrong_number_args?(args_array)
		args_array.size != 1
	end

	def initialize(source)
		@source = source
	end

	def extract_coordinates(gpx_source)
		waypoints = []
		gpx_source.css("trkpt").each do |waypoint|
			coords = {}
			coords[:lat] = waypoint.attribute("lat").value.to_f
			coords[:lon] = waypoint.attribute("lon").value.to_f
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

if GpxParser.wrong_number_args?(ARGV)
	puts "wrong number of arguments"
	puts "correct usage: ruby gpx_parser.rb http://www.example.com"
else
	parser = GpxParser.new(ARGV[0])
	coordinates = parser.parse

	coordinates.each do |pair|
		ap pair
	end
end