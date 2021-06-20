class AddModifiersToForums < ActiveRecord::Migration[6.1]
  def change
    change_column :forums, :title, :string, null: false, limit: 60
    change_column :forums, :description, :string, limit: 120
  end
end
