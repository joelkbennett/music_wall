class Track < ActiveRecord::Base

  belongs_to :user

  validates :song_title, presence: true
  validates :author, presence: true

end