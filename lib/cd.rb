class Cd 
	
	attr_reader :name, :artist

	def initialize(album_name, artist_name)
		@name = album_name
		@artist = artist_name
	end
end