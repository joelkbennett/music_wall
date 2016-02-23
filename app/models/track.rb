class Track < ActiveRecord::Base

  belongs_to :user
  has_many :votes
  has_many :comments

  validates :song_title, presence: true
  validates :author, presence: true

  def user
    user = User.find(user_id)
    "#{user.first_name} #{user.last_name}"
  end

  def added_on
    created_at.strftime('%B %d, %Y')
  end

  def count_up_votes
    votes.where(liked: true).count
  end

  def count_down_votes
    votes.where(liked: false).count
  end

end