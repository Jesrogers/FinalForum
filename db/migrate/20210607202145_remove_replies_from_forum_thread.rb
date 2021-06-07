class RemoveRepliesFromForumThread < ActiveRecord::Migration[6.1]
  def change
    remove_column :forum_threads, :replies
  end
end
