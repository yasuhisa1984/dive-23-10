class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  def self.register!(name)
    tag = Tag.find_by(name: name)
    #存在しなかったら新規登録
    if is_not_registered?(tag)
      tag = Tag.create!(name: name)
    end
    tag
  end


  private
  def self.is_not_registered?(tag)
    tag.nil?
  end
end
