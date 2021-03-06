require 'pry'

require_relative "concerns/findable.rb"

class Genre
  
  extend Concerns::Findable
  
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end 
  
  def save
    @@all << self
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def songs
    @songs
  end
  
  def add_song(song)
    @songs << song  if @songs.include?(song) == false 
    song.genre = self if song.genre == nil
  end 
  
  def artists
    songs.map { |song| song.artist }.uniq
  end
end 