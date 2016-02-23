class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validates :comment, presence: true

  def added_on
    created_at.strftime('%B %d, %Y')
  end

end