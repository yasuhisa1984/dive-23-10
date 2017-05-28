class RenameTypeToNameOnTags < ActiveRecord::Migration
  change_table :tags do |t|
    t.rename :type, :name
  end
end
