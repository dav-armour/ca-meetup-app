class Event < ApplicationRecord
  has_many :event_users
  has_many :users, through: :event_users
  belongs_to :group
  has_many :ratings, dependent: :destroy
end
