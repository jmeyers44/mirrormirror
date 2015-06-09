class Link 
  include Neo4j::ActiveNode

  property :url, type: String
  property :accuracy_rating, type: Integer

  has_one :in, :song

  def increment_rating
    accuracy_rating = self.accuracy_rating + 1
    self.update(accuracy_rating: accuracy_rating)
  end

  def decrement_rating
    accuracy_rating = self.accuracy_rating - 1
    self.update(accuracy_rating: accuracy_rating)
  end

  def self.find_or_create_by(hash)
    if Link.find_by(hash)
      Link.find_by(hash)
    else
      Link.create(hash)
    end
  end

end
