class AddCategoryIdToForum < ActiveRecord::Migration[6.1]
  def change
    add_reference :forums, :forum_category, foreign_key: true
  end
end
