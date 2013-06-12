require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://www.billboard.com/charts/hot-100"

File.open('song_names.txt', 'w') do |f|

page = Nokogiri::HTML(open(PAGE_URL))

song_names = page.css("div.listing.chart_listing h1")
song_names.each { |songs| f.write("#{songs.text}\n") }

end

File.open('artist_names.txt', 'w') do |f|

page = Nokogiri::HTML(open(PAGE_URL))

artist_names = page.css("div.listing.chart_listing p.chart_info a")
artist_names.each { |artists| f.write("#{artists.text}\n") }

end

File.open('chart_positions.txt', 'w') do |f|

page = Nokogiri::HTML(open(PAGE_URL))

chart_positions = page.css("div.listing.chart_listing span.chart_position")
chart_positions.each { |positions| f.write("#{positions.text}\n") }
end




