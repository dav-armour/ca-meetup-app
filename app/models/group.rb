class Group < ApplicationRecord
  validates :name, :urlname, :description, :location, :link, presence: true
  validates :urlname, uniqueness: true
  enum location: [:Sydney, :Brisbane, :Melbourne]

  has_many :events, dependent: :destroy
end
