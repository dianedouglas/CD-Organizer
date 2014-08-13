require 'rspec'
require 'pry'
require 'cd'
require 'genre'

describe 'Genre' do

  before do
    @test_genre = Genre.new({'name' => 'Black Metal'})
    @test_cd = Cd.new({:album_name => 'Konigsforst', :artist_name => 'Gas'})
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

  describe '#add_cd' do

    it 'adds a cd object to the library for this genre.' do
      @test_genre.add_cd(@test_cd)
      expect(@test_genre.library).to eq [@test_cd]
    end

    it 'should not be added a second time if the cd object is already in the genre library.' do
      @test_genre.add_cd(@test_cd)
      @test_genre.add_cd(@test_cd)    
      expect(@test_genre.library).to eq [@test_cd]
    end
  end
end
