class Cd 

  @@all_Cds = []
  attr_accessor :name, :artist

  def initialize(attributes)
    @name = attributes[:album_name]
    @artist = attributes[:artist_name]
  end

  def self.all
    @@all_Cds
  end

  def save 
    @@all_Cds << self
  end

end