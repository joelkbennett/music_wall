class User < ActiveRecord::Base

  has_many :tracks
  has_many :votes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

end