class HasSong 
  include Neo4j::ActiveRel

  property :play_count, type: Integer

  from_class User
  to_class Song
  type 'has_song'

end
