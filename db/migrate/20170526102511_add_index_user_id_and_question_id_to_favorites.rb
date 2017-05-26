class AddIndexUserIdAndQuestionIdToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :question_id], :unique => true
  end
end
