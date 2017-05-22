class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.references :user, index: true, foreign_key: true
      t.text :content, null: false
      t.integer :vote, null: false, default: 0

      t.timestamps null: false
    end
  end
end
