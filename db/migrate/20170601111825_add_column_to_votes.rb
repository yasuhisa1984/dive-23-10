class AddColumnToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :plus_or_minus, :integer
  end
end
