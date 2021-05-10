class RenameOrderToPosition < ActiveRecord::Migration[6.1]
  def change
    rename_column :channels, :order, :position
  end
end
