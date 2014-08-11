require 'rspec'
require 'pry'
require 'cd'

describe 'Cd' do 

  it 'is initialized with an album name and artist name.' do 
    test_cd = Cd.new({:album_name => 'Dimensional Bleedthrough', :artist_name => 'Krallice'})
    expect(test_cd).to be_an_instance_of Cd
    expect(test_cd.name).to eq 'Dimensional Bleedthrough'
    expect(test_cd.artist).to eq 'Krallice'
  end

  describe '.all' do 
    it 'starts empty.' do 
      expect(Cd.all).to eq []
    end
  end

end