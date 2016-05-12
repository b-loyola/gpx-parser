require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


#24-185

page = Nokogiri::HTML(open('index.html'))

test = page.css("table tr td a")

i = 24
while i < 185
  string = test[i].to_s
  string.gsub("&amp", "&")
  string = string.gsub(/\<a href="/, "")
  string = string.gsub(/" .*/, "")
  i+=1
end

