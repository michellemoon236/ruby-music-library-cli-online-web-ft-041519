class Song 
  
  attr_accessor :name, :artist

  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist == nil 
      @artist = artist
    else
      self.artist=(artist)
    end
    if genre == nil 
      @genre = genre
    else
      self.genre=(genre)
    end
  end 
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end 
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def genre
    @genre
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.find_by_name(name)
    self.all.find { |song| song.name == name }
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      Song.create(name)
    else
      self.find_by_name(name) 
    end
  end
  
  def self.new_from_filename(filename)
    #filename_example = "Thundercat - For Love I Come - dance.mp3"
    parts = filename.split(" - ")
    song_name = filename.split(" - ")[1]
    artist_name = parts[0]
    genre_name = parts[2].gsub(".mp3", "")
    song = Song.new(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
  
  def self.create_from_filename(filename)
    #binding.pry 
    self.new_from_filename(filename).save
  end
  
end 
