class User < ActiveRecord::Base

  has_secure_password

  has_many :tracks
  has_many :votes
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 8 }
end