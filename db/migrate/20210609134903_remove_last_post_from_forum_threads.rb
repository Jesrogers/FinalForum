class RemoveLastPostFromForumThreads < ActiveRecord::Migration[6.1]
  def change
    remove_column :forum_threads, :last_post
  end
end
