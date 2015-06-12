class Album 
  include Neo4j::ActiveNode
  property :name, type: String, index: :exact

  has_one :in, :artist
  has_many :out, :songs, rel_type: 'HasTrack'

  def self.find_or_create_by(hash)
    if a = Album.find_by(hash)
      a
    else
      Album.create(hash)
    end
  end
end