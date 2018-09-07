class MusicLibraryController

  def initialize (path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""

    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip
    end

  end

  def list_songs
    songs_list_sorted = Song.all.sort do |a,b|
      a.name <=> b.name
    end

    songs_list_sorted.each.with_index(1) do |song, i|
      #puts artist - song title - genre
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_list_sorted = Artist.all.sort do |a,b|
      a.name <=> b.name
    end

    artist_list_sorted.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    genre_list_sorted = Genre.all.sort do |a,b|
      a.name <=> b.name
    end

    genre_list_sorted.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    artist = Artist.find_by_name(input)

    if artist != nil
          artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
            puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    genre = Genre.find_by_name(input)

    if genre != nil
          genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
            puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end

  def play_song

    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if (1..list_songs.length).include?(input)
      song = list_songs[input-1]
    end 

    puts "Playing #{song.name} by #{song.artist.name}"
  end

end
