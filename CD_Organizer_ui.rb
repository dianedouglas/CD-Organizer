require './lib/cd'
require 'pry'

def main_menu
  	puts "Hi there! Welcome to your music library!"
  loop do
		puts "[c] to Create a CD."
		puts "[l] to List all your albums."
		puts "[x] to exit."
		
		menu_choice = gets.chomp
		if menu_choice == 'c'
			create_cd
		elsif menu_choice == 'x'
			puts "Bye for now!"
			exit
		else 
			puts "Didn't I give you enough options? Perhaps sir could try one of those? :)"
		end

  end
end

def create_cd
	puts "Enter artist name:"
	artist = gets.chomp
	puts "Enter album name:"
	album = gets.chomp
	new_cd = Cd.new({:album_name => album, :artist_name => artist})
	new_cd.save
end

main_menu