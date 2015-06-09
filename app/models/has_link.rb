class HasLink 
  include Neo4j::ActiveRel

  from_class Song
  to_class Link
  type 'has_link'

end
