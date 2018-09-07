class Song

  attr_accessor :name

  #Only need a getter method for artist as we've set a custom setter method below
  attr_reader :artist, :genre

  @@all = []

# initialize with an optional artist & genre
  def initialize(name, artist = nil, genre = nil)
    @name = name
    # if artist is not set tp blank only then run the Song.artist= method
    if artist != nil
      self.artist = artist
    end

    if genre != nil
      self.genre = genre
    end

  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def self.create(name)
      song = Song.new(name)
      song.save
      song
  end

# Custom setter method for genre
# Also runs the .add_song method from the artist and genre - to ensure the song it included in the artist and genres array.
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name == nil
      #then create a new song
      self.create(name)
    end    
  end


end
