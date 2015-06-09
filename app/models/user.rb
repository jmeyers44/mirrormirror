class Song 
  include Neo4j::ActiveNode
  property :name, type: String
  property :track_number, type: Integer

  has_one :in, :album
  has_many :in, :users

  def self.find_or_create_by(hash)
    if Song.find_by(hash)
      Song.find_by(hash)
    else
      Song.create(hash)
    end
  end

end