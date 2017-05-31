class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, dependent: :destroy
  #バリデーション
  validates :content, presence: true
end
