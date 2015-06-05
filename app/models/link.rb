class Link < ActiveRecord::Base
  belongs_to :song

  def increment_rating
    self.accuracy_rating += 1
    self.save
  end

  def decrement_rating
    self.accuracy_rating -= 1
    self.save
  end

end
