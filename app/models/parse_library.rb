class ParseLibrary < ActiveRecord::Base


  def add_library_to_db(file, current_user)
    parse(file)
    @library_array.each do |track_hash|
      artist = add_artist(track_hash["Artist"])
      album = add_album(track_hash["Album"], artist)
      artist.albums << album
      song = add_song(track_hash["Name"], track_hash["Track Number"])
      album.songs << song
      tag = add_tag(track_hash["Genre"])
      song.tags << tag
        if track_hash["Play Count"]
          song.play_count = track_hash["Play Count"]
          song.save
        else
          song.play_count = 0
          song.save
        end
      current_user.songs << song
    end
  end
  
  def parse(file)
    doc = Nokogiri::XML(File.open(file))
    @library_array = []
    doc.xpath('//dict/dict/dict').each do |track|
      obj = {}
      track.children.reject {|node| 
        Nokogiri::XML::Text === node}.each_slice(2) {|(key, value)|
         obj[key.text] = value.text}
      @library_array << obj
    end
    @library_array
  end

  def add_artist(artist)
    if artist
      Artist.find_or_create_by(name: artist)
    else
      Artist.find_or_create_by(name: "unknown")
    end
  end

  def add_album(album, artist)
    if album
      Album.find_or_create_by(name: album)
    else
      if artist 
      Album.find_or_create_by(name: "unknown album #{artist.name}")
      else
      Album.find_or_create_by(name: "unknown album")
      end
    end
  end

  def add_song(song,*track_number)
    if song
    song = Song.find_or_create_by(name: song)
      if track_number
        song.update(track_number: track_number)
      end
    else
      song = Song.create(name: "unknown song")
    end
    song
  end

  def add_tag(genre)
    if genre
      Tag.find_or_create_by(name: genre)
    else
      Tag.find_or_create_by(name: "unknown")
    end
  end




end


