class HasAlbum
  include Neo4j::ActiveRel

  from_class Artist
  to_class Album
  type 'has'

end