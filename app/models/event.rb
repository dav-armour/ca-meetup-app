class Event < ApplicationRecord
  has_many :event_users, dependent: :destroy
  has_many :users, -> { where event_users: { attending: 'going' } }, through: :event_users
  has_many :users_attending, -> { where event_users: { attending: 'going' } }, through: :event_users, source: :user
  has_many :users_unavailable, -> { where event_users: { attending: 'not_going' } }, through: :event_users, source: :user
  belongs_to :group
  has_many :ratings, dependent: :destroy
  has_one :venue, dependent: :destroy
end
