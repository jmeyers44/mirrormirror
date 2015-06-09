class Album 
  include Neo4j::ActiveNode
  property :name, type: String

  has_one :in, :artist
  has_many :out, :songs, rel_type: 'HasTrack'

  def self.find_or_create_by(hash)
    if Album.find_by(hash)
      Album.find_by(hash)
    else
      Album.create(hash)
    end
  end
end