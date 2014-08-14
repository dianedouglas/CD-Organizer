require 'rspec'
require 'pry'
require 'cd'
require 'genre'

describe 'Genre' do

  before do
    @test_genre = Genre.new({'name' => 'Black Metal'})
    @test_cd = Cd.new({:album_name => 'Konigsforst', :artist_name => 'Gas'})
    @test_cd2 = Cd.new({:album_name => 'Winter in the Belly of a Snake', :artist_name => 'Venetian Snares'})
  end

  describe '#initialize' do

    it 'is initialized with a name and saved to the group of all genres.' do
      expect(@test_genre).to be_an_instance_of Genre
    end
  end

  describe '#name' do

    it 'returns the genre name and allows you to write into it.' do
      expect(@test_genre.name).to eq 'Black Metal'
      @test_genre.name = 'Techno'
      expect(@test_genre.name).to eq 'Techno'
      expect(Genre.all[0].name).to eq 'Techno'
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

  describe '#remove_cd' do

    it 'deletes the cd from the genre.' do
      @test_genre.remove_cd(@test_cd)
      expect(@test_genre.library).to eq []      
    end
  end

  describe '#delete_genre' do

    it 'deletes this genre.' do
      expect(Genre.all).to eq [@test_genre]      
      @test_genre.delete_genre
      expect(Genre.all).to eq []      
    end
  end

  describe '.all' do

    it 'returns all genres.' do
      expect(Genre.all).to eq [@test_genre]
    end
  end

  describe '.search_genre_name' do

    it 'returns all genres with names matching the the input string' do
      expect(Genre.search_genre_name('Black Metal')).to eq [@test_genre]
    end
  end
end
