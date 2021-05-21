class RenameForumPostToForumThread < ActiveRecord::Migration[6.1]
  def change
    rename_table :forum_posts, :forum_threads

    add_column :forum_threads, :replies, :integer
    add_column :forum_threads, :last_post, :datetime 
  end
end
