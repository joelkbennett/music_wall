class User < ActiveRecord::Base

  has_secure_password

  has_many :tracks #, dependent: :destroy
  has_many :votes #, dependent: :destroy
  has_many :comments #, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 8 }

  def gravitar
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end
end