require 'pry'

require_relative "concerns/findable.rb"

class Artist 
  
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
    #binding.pry 
    artist = Artist.new(name)
    artist.save
    artist
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def add_song(song)
    @songs << song if @songs.include?(song) == false 
    song.artist = self if song.artist == nil
  end

  def songs
    @songs
  end
  
  def genres 
    songs.map { |song| song.genre }.uniq
  end
  
end 
