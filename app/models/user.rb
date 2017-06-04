class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true
  

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

  def answer_voting_plus_or_minus_or_nil(answer)
    return nil unless votes.find_by(answer_id: answer)
    votes.find_by(answer_id: answer).plus_or_minus
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.create_unique_string
      SecureRandom.uuid
  end

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def contribution_point
    questions = self.questions.includes(:votes)
    return 0 unless questions
    sum = (questions.map { |question| question.voted_point }).sum
    answers = self.answers.includes(:votes)
    return sum unless answers
    sum = sum + (answers.map { |answer| answer.voted_point }).sum
    return sum
  end
end
