class AddIndexToTagRelationships < ActiveRecord::Migration[6.1]
  def change
     add_index :tag_relationships, [:micropost_id,:tag_id],unique: true
  end
end
