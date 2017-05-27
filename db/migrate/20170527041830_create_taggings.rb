class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag, index: true, foreign_key: true, null: false
      t.references :question, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :taggings, [:tag_id, :question_id], :unique => true
  end
end
