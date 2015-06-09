class Artist 
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :out, :albums, rel_type: 'HasAlbum'


  def self.find_or_create_by(hash)
    if Artist.find_by(hash)
      Artist.find_by(hash)
    else
      Artist.create(hash)
    end
  end

end