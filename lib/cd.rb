class Cd 

  @@all_Cds = {}
  attr_accessor :name, :artist

  def initialize(attributes)
    @name = attributes[:album_name]
    @artist = attributes[:artist_name]
  end

  def self.all
    output_Cds = []
    @@all_Cds.each_value do |album|
      output_Cds << album
    end
    output_Cds
  end

  def save 
    @@all_Cds[@name] = self
  end

  def self.search_album_names(name)
    output_Cds = []
    name = name.downcase
    @@all_Cds.each_value do |album|
      if album.name.downcase.include? name
        output_Cds << album
      end
    end  
    output_Cds  
  end

  def self.search_artist_names(name)
    output_Cds = []
    name = name.downcase
    @@all_Cds.each_value do |album|
      if album.artist.downcase.include? name
        output_Cds << album
      end
    end  
    output_Cds  
  end

  def ==(album)
    self.name == album.name && self.artist == album.artist
  end

end