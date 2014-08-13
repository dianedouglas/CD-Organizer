require 'rspec'
require 'pry'
require 'cd'
require 'genre'

describe 'Genre' do

  before do
    @test_genre = Genre.new({'name' => 'Black Metal'})
  end

  describe '#initialize' do

    it 'is initialized with a name.' do
      expect(@test_genre).to be_an_instance_of Genre
    end
  end

  describe '#name' do

    it 'returns the genre name and allows you to write into it.' do
      expect(@test_genre.name).to eq 'Black Metal'
      @test_genre.name = 'Techno'
      expect(@test_genre.name).to eq 'Techno'
    end
  end
end
