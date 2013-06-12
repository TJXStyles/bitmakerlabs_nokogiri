require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://www.billboard.com/charts/hot-100"

page = Nokogiri::HTML(open(PAGE_URL))

top10 = page.css("div.listing.chart_listing h1")


top10.each do |track_name|
	puts track_name.text
end


