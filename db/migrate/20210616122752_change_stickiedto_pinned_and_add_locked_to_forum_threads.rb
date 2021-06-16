class ChangeStickiedtoPinnedAndAddLockedToForumThreads < ActiveRecord::Migration[6.1]
  def change
    rename_column :forum_threads, :stickied, :pinned
    add_column :forum_threads, :locked, :boolean, default: false
  end
end
