class RemoveVoteFromAnswer < ActiveRecord::Migration
  def change
    remove_column :answers, :vote, :integer
  end
end
