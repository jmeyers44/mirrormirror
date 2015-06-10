class HasTrack 
  include Neo4j::ActiveRel

  from_class Album
  to_class Song
  type 'has_track'

end
