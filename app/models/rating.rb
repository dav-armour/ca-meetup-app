class Rating < ApplicationRecord
  belongs_to :event
  belongs_to :user

  # Creates a hash of rating values
  def to_hash
    { food: self.food, drinks: self.drinks, talks: self.talks, vibe: self.vibe }
  end
end
