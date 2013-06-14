require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Billboard_top_10

	BILLBOARD = "http://www.billboard.com/charts/hot-100"


	def initialize
		@song_names = []
		@artist_names = []
		@lyrics_array = []
		@youtube_array = []
	end

	
	def scrape_song_names
		page = Nokogiri::HTML(open(BILLBOARD))
		original_song_names = page.css("div.listing.chart_listing h1")
		original_song_names.each { |songs| @song_names << songs.text }
	end

	def scrape_artist_names
		page = Nokogiri::HTML(open(BILLBOARD))
		original_artist_names = page.css("div.listing.chart_listing p.chart_info a")
		original_artist_names.each { |artists| @artist_names << artists.text }
	end


	def scrape_lyrics
		@song_names.each_with_index do |song, index|

			song = song.gsub(" ", "%20")
			artist = @artist_names[index].gsub(" ", "%20")
			

			search_page = Nokogiri::HTML(open("http://www.songlyrics.com/index.php?section=search&searchW=#{song}+#{artist}&submit=Search"))

			# Grabs the link of the first search result
			lyric_results = search_page.css(".serpresult h3 a")[0]['href']
			lyrics_url = Nokogiri::HTML(open(lyric_results))
			lyrics = lyrics_url.css("div#songLyricsDiv-outer p")
			puts "Just retrieved #{@artist_names[index]} - #{@song_names[index]} lyrics..."
			@lyrics_array << lyrics
		end
	end

	def scrape_youtube

		@song_names.each_with_index do |song, index|
			youtube_search = @artist_names[index] + "+" + song
			youtube_search.gsub!(" ", "+").gsub!("&", "%26")
			youtube = Nokogiri::HTML(open("http://www.youtube.com/results?search_query=#{youtube_search}"))
			
			video_id = youtube.css("ol#search-results h3.yt-lockup2-title a")[0]['href']
			video_id.slice!(/\/watch\?v=/)

			@youtube_array << video_id

			puts "Serving up your video of #{song} by #{@artist_names[index]}!!!"
			
			
		end
 
	end
	
		
	def write_html
		File.open('chart_positions.html', 'w') do |html|
		

			for i in 1..@song_names.length

				html.write("\t<div class='container'>\n")
				html.write("\t\t<div class='youtube'>\n")
				html.write("\t\t\t<iframe width='498' height='280' src='http://www.youtube.com/embed/#{@youtube_array[i-1]}' frameborder='0' allowfullscreen></iframe>\n")
				html.write("\t\t</div>\n")
				html.write("\t\t<div class='number'><p>\##{i}</p></div>\n")
				html.write("\t\t<div class='song-container'>\n")
				# html.write("\t\t\t<p>\n")
				html.write("\t\t\t\t<h1>#{@song_names[i-1]}</h1>\n")
				html.write("\t\t\t\t<h2 class='artist'>#{@artist_names[i-1]}</h2>\n")
				# html.write("\t\t\t</p>\n")		
				html.write("\t\t</div>\n")
				html.write("\t\t<div class='lyrics'>\n")
				html.write("\t\t\t<h3>Lyrics</h3>\n")
				html.write("#{@lyrics_array[i-1]}")
				html.write("\t\t</div>")
				html.write("\t</div>")
				


					# if i < @song_names.length
					# # html.write("\t\t<div class='next-song'>\n")
					# # html.write("\t\t\t<a href='\#section#{i+1}'>Next song</a>\n")
					# # html.write("\t\t</div>\n")
					# # html.write("</div> <!-- Ending section div -->")
					# end
			end
		end

	end

	def run
		scrape_song_names
		scrape_artist_names
		scrape_lyrics
		scrape_youtube
		write_html
	end



end


Billboard_top_10.new.run















# page = Nokogiri::HTML(open(PAGE_URL))

# album_name = page.css("p.chart_info")
# # album_name.each { |album| f.write("#{album.text[\s*<br>\s*(\w+)\s*]}") }

# puts album_name[/\s*<br>\s*(\w+)\s*/]



