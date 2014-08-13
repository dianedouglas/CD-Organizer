require 'cd'

class Genre

  @@all_genres = {}
  attr_accessor :name, :library

  def initialize(attributes)
    @name = attributes['name']
    @library = attributes['library']
    if @library == nil
      @library = []
    end
    @@all_genres[@name] = self
  end

  def add_cd(cd)
    if !@library.include? cd
      @library << cd
    end
  end

  def self.all
    genres = []
    @@all_genres.each_value do |genre|
      genres << genre
    end
    genres
  end

  def delete_cd(cd)
    @library.delete(cd)
  end

  def delete_genre
    @@all_genres.delete(self.name)
  end
end