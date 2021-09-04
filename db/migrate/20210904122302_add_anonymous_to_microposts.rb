class AddAnonymousToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :anonymous, :boolean
  end
end
