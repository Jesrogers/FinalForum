class AddAuthorIdToForumPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :forum_posts, :author, foreign_key: { to_table: :users }
  end
end
