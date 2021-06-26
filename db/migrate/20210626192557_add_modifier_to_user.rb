class AddModifierToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :biography, :text, limit: 1200
  end
end
