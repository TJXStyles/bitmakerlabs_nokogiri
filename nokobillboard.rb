require 'rubygems'
require 'nokogiri'
require 'open-uri'

BILLBOARD = "http://www.billboard.com/charts/hot-100"

song_names = []
artist_names = []

page = Nokogiri::HTML(open(BILLBOARD))
original_song_names = page.css("div.listing.chart_listing h1")
original_song_names.each { |songs| song_names << songs.text }

page = Nokogiri::HTML(open(BILLBOARD))
original_artist_names = page.css("div.listing.chart_listing p.chart_info a")
original_artist_names.each { |artists| artist_names << artists.text }



	song_names.each_with_index do |song, index|

		song = song.gsub(" ", "%20")
		artist = artist_names[index].gsub(" ", "%20")
		

		search_page = Nokogiri::HTML(open("http://www.songlyrics.com/index.php?section=search&searchW=#{song}+#{artist}&submit=Search"))

		# Grabs the link of the first search result
		lyric_results = search_page.css(".serpresult h3 a")[0]['href']
		lyrics_url = Nokogiri::HTML(open(lyric_results))
		lyrics = lyrics_url.css("div#songLyricsDiv-outer p").text


	end


	


	



	

	










# File.open('chart_positions.html', 'w') do |html|
	

# 	for i in 1..song_names.length
# 		html.write("<div class='section' id='section#{i}'>\n")
# 		html.write("\t<div class='bg-opacity'></div>\n")
# 		html.write("\t<div class='float'></div>\n")
# 		html.write("\t<div class='container'>\n")
# 		html.write("\t\t<div class='youtube'>\n")
# 		html.write("\t\t\t<iframe width='498' height='280' src='http://www.youtube.com/embed/fF_sD_poO2Y' frameborder='0' allowfullscreen></iframe>\n")
# 		html.write("\t\t</div>\n")
# 		html.write("\t\t<div class='number'><p>\##{i}</p></div>\n")
# 		html.write("\t\t<div class='song-container'>\n")
# 		html.write("\t\t\t<p>\n")
# 		html.write("\t\t\t\t<h1>#{song_names[i-1]}</h1>\n")
# 		html.write("\t\t\t\t<h2 class='artist'>#{artist_names[i-1]}</h2>\n")
# 		html.write("\t\t\t</p>\n")		
# 		html.write("\t\t</div>\n")
# 		html.write("\t</div>\n\n")


# 		if i < song_names.length
# 			html.write("\t\t<div class='next-song'>\n")
# 			html.write("\t\t\t<a href='\#section#{i+1}'>Next song</a>\n")
# 			html.write("\t\t</div>\n")
# 			html.write("</div> <!-- Ending section div -->")
# 		end

# 	end
# end










# page = Nokogiri::HTML(open(PAGE_URL))

# album_name = page.css("p.chart_info")
# # album_name.each { |album| f.write("#{album.text[\s*<br>\s*(\w+)\s*]}") }

# puts album_name[/\s*<br>\s*(\w+)\s*/]



