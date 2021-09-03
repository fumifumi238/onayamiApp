class CreateTroubles < ActiveRecord::Migration[6.1]
  def change
    create_table :troubles do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
     add_index :troubles, [:user_id, :created_at]
  end
end
