class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true, null: false, unique: true
      t.references :question, index: true, foreign_key: true, null: false, unique: true
      t.references :answer, index: true, foreign_key: true, null: false, unique: true
      t.timestamps null: false
    end
  end
end
