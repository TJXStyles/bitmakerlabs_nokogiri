require 'rubygems'
require 'nokogiri'
require 'open-uri'

File.open('chart_positions.html', 'w') do |html|
	song_names = []
	artist_names = []

	File.open('song_names.txt', 'r') do |song|
		while (line = song.gets)
			song_names << line.chomp
		end
	end

	File.open('artist_names.txt', 'r') do |artist|
		while (line = artist.gets)
			artist_names << line.chomp
		end
	end

	for i in 1..song_names.length
		html.write("<div class='section' id='section#{i}'>\n")
		html.write("\t<div class='bg-opacity'></div>\n")
		html.write("\t<div class='float'></div>\n")
		html.write("\t<div class='container'>\n")
		html.write("\t\t<div class='youtube'>\n")
		html.write("\t\t\t<iframe width='498' height='280' src='http://www.youtube.com/embed/fF_sD_poO2Y' frameborder='0' allowfullscreen></iframe>\n")
		html.write("\t\t</div>\n")
		html.write("\t\t<div class='number'><p>#{i}</p></div>\n")
		html.write("\t\t<div class='song-container'>\n")
		html.write("\t\t\t<p>\n")
		html.write("\t\t\t\t<h1>#{song_names[i]}</h1>\n")
		html.write("\t\t\t\t<h2 class='artist'>#{artist_names[i]}</h2>\n")
		html.write("\t\t\t</p>\n")		
		html.write("\t\t</div>\n\n")


		if i < song_names.length
			html.write("\t\t<div class='next-song'>\n")
			html.write("\t\t\t<a href='#section#{i+1}'>Next song</a>\n")
			html.write("\t\t</div>\n")
			html.write("</div> <!-- Ending section div -->")
		end


		



	end
















end
	
