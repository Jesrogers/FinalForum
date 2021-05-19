class RemoveAuthorFromForum < ActiveRecord::Migration[6.1]
  def change
    remove_column :forums, :author
  end
end
