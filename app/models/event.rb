class Event < ApplicationRecord
  belongs_to :group
  has_many :ratings, dependent: :destroy
end
