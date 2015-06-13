class ParseLibrary 
  # include Neo4j::ActiveNode
  include ActionController::Live
  def add_library_to_db(file, current_user_id)
    parse(file)
    # current_user = {username: "flash"}
    new_user = User.find(current_user_id)
    new_user.update(total_plays: 0)
    @library_array.each do |track_hash|
      next if track_hash["TV Show"] || track_hash["Podcast"]
      artist = add_artist(track_hash["Artist"])
      album = add_album(track_hash["Album"], artist)
      HasAlbum.create(from_node: artist, to_node: album)
      # artist.albums << album

      song = add_song(track_hash["Name"], track_hash["Track Number"])
      # album.songs << song
      HasTrack.create(from_node: album, to_node: song)


      # tag = add_tag(track_hash["Genre"])
      # song.tags << tag
      
      # new_user.songs << song
      # usersong = UserSong.where(song_id: song.id, user_id: current_user.id).first
        if track_hash["Play Count"]
          HasSong.create(from_node: new_user, to_node: song, play_count: track_hash["Play Count"]) 
          current_total_plays = new_user.total_plays
          new_total_plays = current_total_plays + track_hash["Play Count"].to_i
          new_user.update(total_plays: new_total_plays)
        else
          HasSong.create(from_node: new_user, to_node: song, play_count: 0)
        end
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

end



