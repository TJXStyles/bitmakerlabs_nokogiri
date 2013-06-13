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


# page = Nokogiri::HTML(open(PAGE_URL))

# album_name = page.css("p.chart_info")
# # album_name.each { |album| f.write("#{album.text[\s*<br>\s*(\w+)\s*]}") }

# puts album_name[/\s*<br>\s*(\w+)\s*/]



