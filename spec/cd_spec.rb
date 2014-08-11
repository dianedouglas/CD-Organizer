require 'rspec'
require 'pry'
require 'cd'

describe 'Cd' do 

  it 'is initialized with an album name and artist name.' do 
    test_cd = Cd.new('Dimensional Bleedthrough', 'Krallice')
    expect(test_cd).to be_an_instance_of Cd
  end
end