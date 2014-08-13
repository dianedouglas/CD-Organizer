require 'rspec'
require 'pry'
require 'cd'
require 'genre'

describe 'Genre' do

  before do
    @test_genre = Genre.new({'name' => 'Black Metal'})
  end

  it 'is initialized with a name.' do
    expect(@test_genre).to be_an_instance_of Genre
  end
end
