class Cd 

  @@all_Cds = {}
  attr_accessor :name, :artist

  def initialize(attributes)
    @name = attributes[:album_name]
    @artist = attributes[:artist_name]
  end

  def self.all
    output_Cds = []
    @@all_Cds.each do |key, value|
      output_Cds << value
    end
    output_Cds
  end

  def save 
    @@all_Cds[@name] = self
  end

end