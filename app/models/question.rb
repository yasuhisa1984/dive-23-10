class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorite_by(user)
    favorites.find_by(user_id: user.id)
  end
end
