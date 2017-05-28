class RemoveVoteFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :vote, :integer
  end
end
