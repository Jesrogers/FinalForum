class ForumRenameOrderToPosition < ActiveRecord::Migration[6.1]
  def change
    rename_column :forums, :order, :position

    change_column_default :forums, :position, 1
    change_column_default :forums, :locked, false
  end
end
