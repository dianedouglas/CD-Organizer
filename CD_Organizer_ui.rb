require './lib/genre'
require './lib/cd'
require 'pry'

@current_genre = nil

def main_menu
  	puts "Hi there! Welcome to your music library!"
  loop do
  	puts "\n"
		puts "[c] to Create a CD."
		puts "[print cds] to list all your albums."
		puts "[title] to search by Title for a particular album."
		puts "[artist] to see which Cds you have by an Artist."
		puts "[edit cd] to Edit the information on a Cd."
		
		puts ""
		puts "[g] to Create a Genre."
		puts "[a] to Add a CD to a Genre."
		puts "[print genres] to list all the Genres in your collection."
		puts "[genre] to print out all albums in a particular genre."
		puts "[edit genre] to Edit a Genre."
		puts "[x] to eXit."
		
		menu_choice = gets.chomp.downcase
		if menu_choice == 'c'
			create_cd
		elsif menu_choice == 'print cds'
			print_cds
		elsif menu_choice == 'title'
			search_title
		elsif menu_choice == 'artist'
			search_artist
		elsif menu_choice == 'edit cd'
			edit_cd

		elsif menu_choice == 'g'
			create_genre
		elsif menu_choice == 'a'
			add_cd_to_genre
		elsif menu_choice == 'print genres'
			print_genres
		elsif menu_choice == 'genre'
			search_genre
		elsif menu_choice == 'edit genre'
			edit_genre
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
	puts ""
	puts "Enter artist name:"
	artist = gets.chomp
	puts "Enter album name:"
	album = gets.chomp
	new_cd = Cd.new({:album_name => album, :artist_name => artist})
	new_cd.save
end

def print_cds
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
	print_cds
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

def create_genre
	puts ""
	puts "Enter genre name:"
	genre = gets.chomp
	new_genre = Genre.new({'name' => genre})
end

def select_genre

	puts "Select the genre you want."
	print_genres
	count = 0
	genre = gets.chomp
	genres = Genre.search_genre_name(genre)
	if genres.length == 0
		puts "You haven't created that genre yet!"
	elsif genres.length == 1
		puts ""
		puts "You selected: "
		puts "#{genres[0].name}"
		puts ""
		@current_genre = genres[0]
	else
		puts "Hmm... I have these."
		genres.each do |genre|
			puts "#{genre.name}"
			puts ""
			sleep 1
			puts "Do you mean one of them?"
		end
		select_genre
	end

end

def add_cd_to_genre
	puts "Enter the title of the album you add."
	count = 0
	print_cds
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
		@current_genre.add_cd(cds[0])
	else 
		puts "Hmm... I have these."
		cds.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}\n"
			puts ""
			sleep 1
		end
		add_cd_to_genre
	end
end

def print_genres
	puts "Let's see now..."
	sleep 1
	puts ...
	all_genres = Genre.all
	if all_genres.length == 0
		puts "It looks like you don't have any yet, sorry!"
	else
		all_genres.each do |genre|
			puts "#{genre.name}"
			puts ""
			sleep 1
		end
	end
end

def search_genre
	select_genre
	puts "OK, here is all the #{@current_genre.name} you have..."
		@current_genre.library.each do |cd|
			puts "#{cd.name}"
			puts "By #{cd.artist}\n"
			puts ""
			sleep 1
		end
end

def edit_genre
	select_genre
	loop do
		puts ""
		puts "[n] to change the name of the genre."
		puts "[delete cd] to delete a cd from the genre."
		puts "[delete genre] to delete the genre."
		puts ""
		menu_choice = gets.chomp.downcase

		if menu_choice == 'n'
			name = gets.chomp
			@current_genre.name = name
			puts "Like this right?"
			puts "#{@current_genre.name}:"
			puts ""
			@current_genre.library.each do |cd|
				puts "#{cd.name}"
				puts "By #{cd.artist}\n"
				puts ""
				sleep 1
			end
		elsif menu_choice == 'delete cd'
			selected_cd = select_cd
			@current_genre.delete_cd(selected_cd)
			puts "It's gone!"
		elsif menu_choice == 'delete genre'
			@current_genre.delete_genre
			puts "It's gone!"		
		else
			puts "Sorry! That's not a valid menu choice. Try again?"
		end
	end
end

main_menu