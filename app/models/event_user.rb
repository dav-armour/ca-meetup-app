class EventUser < ApplicationRecord
  enum attending: [:not_going, :going]

  belongs_to :user
  belongs_to :event
end
