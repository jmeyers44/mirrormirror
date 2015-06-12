class Song 
  include Neo4j::ActiveNode
  property :name, type: String, index: :exact
  property :track_number, type: Integer, index: :exact

  has_one :in, :album
  has_many :in, :users
  has_many :out, :links, rel_type: 'HasLink'

  def self.find_or_create_by(hash)
    if s = Song.find_by(hash)
      s
    else
       Song.create(hash)
    end
  end

end