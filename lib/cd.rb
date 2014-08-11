class Cd 

	attr_reader :name, :artist

	def initialize(attributes)
		@name = attributes[:album_name]
		@artist = attributes[:artist_name]
	end
end