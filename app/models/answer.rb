class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, dependent: :destroy

  def voted_point
    self.votes.sum(:plus_or_minus)
  end
end
