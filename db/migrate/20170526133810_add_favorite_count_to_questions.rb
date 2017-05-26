class AddFavoriteCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :favorites_count, :integer, default: 0
  end
end
