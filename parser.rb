require 'nokogiri'
require 'open-uri'
require 'pry'
require 'awesome_print'

class Parser

	def self.wrong_number_args?(args_array)
		args_array.size != 1
	end

	def initialize(source)
		@source = source
	end

	def extract_seasons(stats)
		stats.scan(/spring|winter|fall|summer/i)
	end

	def extract_difficulty(stats)
		stats.slice(/easy|moderate|difficult|extreme/i)
	end

	def extract_hours(stats)
		stats.slice(/\d+\.?\d*\s*hours?/).to_i
	end

	def extract_distance(stats)
		stats.slice(/\d+\.?\d*\s*kms?/).to_i
	end

	def extract_description(text_box)
		text_box.xpath('text()').text.strip
	end

	def parse
		source = Nokogiri::HTML(open(@source))
		stats = source.css("div#stats").to_s
		
		seasons = extract_seasons(stats)
		difficulty = extract_difficulty(stats)
		hours = extract_hours(stats)
		distance = extract_distance(stats)

		text_box = source.css("div#description")
		description = extract_description(text_box)
		[seasons, difficulty, hours, distance, description]
	end

end

# if Parser.wrong_number_args?(ARGV)
# 	puts "wrong number of arguments"
# 	puts "correct usage: ruby parser.rb http://www.example.com"
# else
# 	parser = Parser.new(ARGV[0])
# 	hike_stats = parser.parse

# 	ap hike_stats
# 	# binding.pry
# end