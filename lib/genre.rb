class Genre

  attr_accessor :name

  def initialize(attributes)
    @name = attributes['name']
  end
end