require './lib/cd'
require 'pry'

def main_menu
  	puts "Hi there! Welcome to your music library!"
  loop do
  	puts "\n"
		puts "[c] to Create a CD."
		puts "[l] to List all your albums."
		puts "[title] to search by title for a particular album."
		puts "[artist] to see which albums you have by an artist."
		puts "[e] to edit the information on a cd."
		puts "[x] to exit."
		
		menu_choice = gets.chomp
		if menu_choice == 'c'
			create_cd
		elsif menu_choice == 'l'
			list_cds
		elsif menu_choice == 'title'
			search_title
		elsif menu_choice == 'artist'
			search_artist
		elsif menu_choice == 'e'
			edit_cd
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
			puts "By #{cd.artist}\n"
			puts ""
			sleep 1
		end
	end
end

def search_title
	puts "Please enter the title of the cd you want to find: "
	title = gets.chomp
	sleep 1
	cds = Cd.search_album_names(title)
	if cds.length == 0
		puts "I'm afraid you don't have #{title}!"
	else
		puts "Here's what I got for ya...\n"
		puts ""
		cds.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}\n"
			puts ""
			sleep 1
		end
		puts "Hope I found it!"
		puts ""
	end
end

def search_artist
	puts "Who are you looking for? Enter an artist name: "
	title = gets.chomp
	sleep 1
	puts "Lets see... #{title}..."
	sleep 1
	cds = Cd.search_artist_names(title)
	if cds.length == 0
		puts "I'm afraid you don't have anything by #{title}!"
	else
		puts "Here's what I could find...\n"
		cds.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}"
			puts ""
			sleep 1
		end
	end
end

def cd_selected(cd)
	puts "[t] to change the Title."
	puts "[a] to change the Artist."
	puts "[m] to go back to the main menu."
	menu_choice = gets.chomp
	if menu_choice == "t"
		loop do
			puts "Enter the new title: "
			title = gets.chomp
			cd.name = title
			puts "Got it."
			puts ""
			puts "#{cd.name}"
			puts "By #{cd.artist}"
			puts ""
			puts "Is that correct? y/n"
			correct = gets.chomp
			if correct == 'y'
				puts "Cool!"
				cd_selected(cd)
			else
				puts "Ok, let's try again."
			end
		end
	elsif menu_choice == 'a'
		loop do
			puts "Enter the new artist name: "
			artist = gets.chomp
			cd.artist = artist
			puts "Got it."
			puts ""
			puts "#{cd.name}"
			puts "By #{cd.artist}"
			puts ""
			puts "Is that correct? y/n"
			correct = gets.chomp
			if correct == 'y'
				puts "Cool!"
				cd_selected(cd)
			else
				puts "Ok, let's try again."
			end			
		end
	elsif menu_choice == 'm'
		main_menu
	else
		puts "Not sure what you mean..."
		puts ""
		cd_selected(cd)
	end
end

def edit_cd
	puts "Enter the title of the album you want to edit."
	count = 0
	list_cds
	title = gets.chomp
	cds = Cd.search_album_names(title)
	if cds.length == 0
		puts "I'm afraid you don't have #{title}!"
	elsif cds.length == 1
		puts ""
		puts "You selected: "
		puts "#{cds[0].name}"
		puts "By #{cds[0].artist}"
		puts ""
		cd_selected(cds[0])
	else 
		puts "Hmm... I have these."
		cds.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}\n"
			puts ""
			sleep 1
		end
		edit_cd
	end
end

main_menu