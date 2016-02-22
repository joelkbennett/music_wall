class Track < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :song_title, presence: true
  validates :author, presence: true

end