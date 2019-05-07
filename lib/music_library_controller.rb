class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    @music_array = MusicImporter.new(@path).import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    input = ""
    while input
      input = gets.downcase.chomp
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      when "exit"
        break
      end
    end
  end
  
  #example song list: ["Action Bronson - Larry Csonka - indie.mp3", "Real Estate - Green Aisles - country.mp3", "Real Estate - It's Real - hip-hop.mp3", "Thundercat - For Love I Come - dance.mp3","Jurassic 5 - What's Golden - hip-hop.mp3"]
  
  def list_songs
    alphabetized = Song.all.sort_by { |song| song.name }
    alphabetized.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
    
  end
  
  def list_artists
    alphabetized = Artist.all.sort_by { |artist| artist.name }
    alphabetized.each.with_index(1) { |artist, index| puts "#{index}. #{artist.name}" }
  end
  
  def list_genres
    alphabetized = Genre.all.sort_by { |genre| genre.name }
    alphabetized.each.with_index(1) { |genre, index| puts "#{index}. #{genre.name}" }   
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    if Artist.find_by_name(artist_name)
    Artist.find_by_name(artist_name).songs.sort_by { |song| song.name }.each.with_index(1) { |song, index| puts "#{index}. #{song.name} - #{song.genre.name}" }
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    if Genre.find_by_name(genre_name)
    Genre.find_by_name(genre_name).songs.sort_by { |song| song.name }.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name}" }
    end    
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp  
    #binding.pry
    if input.to_i.class == Integer && input.to_i <= Song.all.length && input.to_i > 0
      alphabetized = Song.all.sort_by { |song| song.name }
      puts "Playing #{alphabetized[(input.to_i)-1].name} by #{alphabetized[(input.to_i)-1].artist.name}"  
    end
  end  

end