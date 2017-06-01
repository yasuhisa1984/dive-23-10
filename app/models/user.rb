class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :votes, dependent: :destroy

  def self.all_except(user)
    where.not(id: user.id)
  end

  def question_voting_plus_or_minus_or_nil(question)
    return nil unless votes.find_by(question_id: question)
    votes.find_by(question_id: question).plus_or_minus
  end
end
