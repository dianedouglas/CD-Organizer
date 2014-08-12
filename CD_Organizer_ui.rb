require './lib/cd'
require 'pry'

def main_menu
  	puts "Hi there! Welcome to your music library!"
  loop do
  	puts "\n"
		puts "[c] to Create a CD."
		puts "[l] to List all your albums."
		puts "[x] to exit."
		
		menu_choice = gets.chomp
		if menu_choice == 'c'
			create_cd
		elsif menu_choice == 'l'
			list_cds
		elsif menu_choice == 'x'
			puts "Bye for now!"
			exit
		else 
			puts "Didn't I give you enough options? Perhaps sir could try one of those? :)"
			puts "\n"
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

def list_cds
	puts "Let's see now..."
	sleep 1
	puts ...
	all_cds = Cd.all
	if all_cds.length == 0
		puts "It looks like you don't have any yet, sorry!"
	else
		all_cds.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}"
			puts "\n"
			sleep 1
		end
	end
end

main_menu