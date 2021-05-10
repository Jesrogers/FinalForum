class RenameForumCategoryColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :forums, :forum_category_id, :channel_id
  end
end
