class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ratings
  has_many :event_users
  has_many :events, -> { where event_users: { attending: 'going' } }, through: :event_users
  # has_many :events, through: :event_users, -> { where(groups: {active: true}) }

  def first_name
    self.name.split.first
  end
end
