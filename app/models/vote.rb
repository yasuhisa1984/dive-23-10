class Vote < ActiveRecord::Base
  belongs_to: users
  has_many: answers
  has_many: questions
end
