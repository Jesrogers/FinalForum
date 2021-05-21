class AddForumIdToForumThreads < ActiveRecord::Migration[6.1]
  def change
    add_reference :forum_threads, :forum, foreign_key: true
  end
end
