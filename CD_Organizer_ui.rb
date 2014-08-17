require './lib/genre'
require './lib/cd'

@current_genre = nil
@current_genre_copy = nil

def welcome
  puts ""
  puts ""
  puts "Hi there! Welcome to your music library!"
  main_menu
end

def main_menu
  loop do
    puts ""
    puts "Please choose an option..."
    puts ""
    puts "CDs:"
    puts ""
    puts "Enter [c] to Create a CD."
    puts "Enter [print cds] to list all your albums."
    puts "Enter [title] to search by Title for a particular album."
    puts "Enter [artist] to see which Cds you have by an Artist."
    puts "Enter [edit cd] to Edit the information on a Cd."
    puts ""
    puts "Genres:"
    puts ""
    puts "Enter [g] to Create a Genre."
    puts "Enter [a] to Add a CD to a Genre."
    puts "Enter [print genres] to list all the Genres in your collection."
    puts "Enter [genre] to print out all albums in a particular genre."
    puts "Enter [edit genre] to Edit a Genre."
    puts ""
    puts "Enter [x] to eXit."

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
      select_cd_to_edit
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
      puts ""
    end
  end
end

#cd methods:

def select_cd(force_selection)
  title = gets.chomp
  count = 0
  cds = Cd.search_album_names(title)
  if cds.length == 0
    puts "I'm afraid you don't have #{title}!"
  elsif cds.length == 1
    puts ""
    puts "You selected: "
    puts "#{cds[0].name}"
    puts "By #{cds[0].artist}"
    puts ""
    sleep 1
    return cds[0]
  else
    puts "Hmm... I have these."
    cds.each do |cd|
      puts "#{cd.name}"
      puts "By #{cd.artist}\n"
      puts ""
      sleep 1
    end
    if (force_selection)
      select_cd
    else
      puts "Hope I found it!"
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
  puts "..."
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
  select_cd(false)
end

def search_artist
  puts "Who are you looking for? Enter an artist name: "
  artist = gets.chomp
  sleep 1
  puts "Lets see... #{artist}..."
  sleep 1
  cds = Cd.search_artist_names(artist)
  if cds.length == 0
    puts "I'm afraid you don't have anything by #{artist}!"
  else
    puts "Here's what I could find..."
    puts ""
    cds.each do |cd|
      puts "#{cd.name}"
      puts "By #{cd.artist}"
      puts ""
      sleep 1
    end
    puts "Hope I found it!"
  end
end

def edit_cd(cd)
  puts "[t] to change the Title."
  puts "[a] to change the Artist."
  puts "[m] to go back to the main menu."
  menu_choice = gets.chomp.downcase
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
        edit_cd(cd)
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
        edit_cd(cd)
      else
        puts "Ok, let's try again."
      end
    end
  elsif menu_choice == 'm'
    main_menu
  else
    puts "Not sure what you mean..."
    puts ""
    edit_cd(cd)
  end
end

def select_cd_to_edit
  puts ""
  puts "Please enter the name of the cd you would like to edit."
  puts ""
  sleep 1
  print_cds
  cd_to_edit = select_cd(true)
  edit_cd(cd_to_edit)
end

#genre methods:

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
    puts "Press [a] to add the genre."
    puts "Press [s] to select a different one."
    selection = gets.chomp
    if selection == 'a'
      new_genre = Genre.new({'name' => genre})
      @current_genre = new_genre
      puts "Added #{@current_genre.name}."
      sleep 1
    else
      select_genre
    end
  elsif genres.length == 1
    puts ""
    puts "You selected: "
    puts "#{genres[0].name}"
    puts ""
    sleep 1
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
  if Genre.all.length == 0
    puts "You don't have any genres yet! Please make one first."
    sleep 1
    main_menu
  else
    puts "Enter the title of the album you want to add."
    count = 0
    print_cds
    cd_to_add = select_cd(true)
    select_genre
    @current_genre.add_cd(cd_to_add)
    print_cds_from_genre
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
  print_cds_from_genre
end

def print_cds_from_genre
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
      puts ""
      puts "Please enter the new genre name."
      name = gets.chomp
      @current_genre_copy = Genre.new({'name' => @name, 'library' => @current_genre.library})
      @current_genre.delete_genre
      @current_genre = @current_genre_copy
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
      puts "Enter the name of the cd to delete from this genre."
      selected_cd = select_cd(true)
      @current_genre.remove_cd(selected_cd)
      puts "It's gone!"
      sleep 1
      main_menu
    elsif menu_choice == 'delete genre'
      @current_genre.delete_genre
      puts "It's gone!"
      sleep 1
      main_menu
      break
    else
      puts "Sorry! That's not a valid menu choice. Try again?"
    end
  end
end

welcome
