class Event < ApplicationRecord
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  belongs_to :group
  has_many :ratings, dependent: :destroy
  has_one :venue, dependent: :destroy
end
