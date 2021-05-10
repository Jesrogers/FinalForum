class RenameForumCategoryToChannel < ActiveRecord::Migration[6.1]
  def change
    rename_table :forum_categories, :channels
  end
end
