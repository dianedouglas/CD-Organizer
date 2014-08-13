require 'cd'

class Genre

  attr_accessor :name, :library

  def initialize(attributes)
    @name = attributes['name']
    @library = attributes['library']
    if @library == nil
      @library = []
    end
  end

  def add_cd(cd)
    @library << cd
  end
end