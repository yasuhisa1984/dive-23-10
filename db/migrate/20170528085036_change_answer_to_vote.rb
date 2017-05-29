class ChangeAnswerToVote < ActiveRecord::Migration
  # 変更内容
  def up
    change_column :votes, :question_id, :integer, null: true
    change_column :votes , :answer_id, :integer, null: true
  end

  # 変更前の状態
  def down
    change_column :votes , :question_id, :integer, null: false
    change_column :votes , :answer_id, :integer, null: false
  end
end
