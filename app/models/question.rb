class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :votes, dependent: :destroy

  def favorite_by(user)
    favorites.find_by(user_id: user.id)
  end

  def self.favorite_ranking(num)
    self.order(favorites_count: :DESC).limit(num)
  end

  def voted_point
    self.votes.sum(:plus_or_minus)
  end
end
