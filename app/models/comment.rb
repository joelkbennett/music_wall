class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validates :comment, presence: true
  validate :check_reviewer

  def added_on
    created_at.strftime('%B %d, %Y')
  end

  def track_name
    track.song_title
  end

  private

  def check_reviewer
    review = Comment.where(user_id: user_id).where(track_id: track_id)
    if review[0]
      errors.add(:user_id, "User has already reviewed")
    end
  end

end