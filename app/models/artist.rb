class Artist 
  include Neo4j::ActiveNode
  property :name, type: String, index: :exact

  has_many :out, :albums, rel_type: 'HasAlbum'


  def self.find_or_create_by(hash)
    if a = Artist.find_by(hash)
      a
    else
      Artist.create(hash)
    end
  end

end