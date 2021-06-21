class AddModifiersToForumThreads < ActiveRecord::Migration[6.1]
  def change
    change_column :forum_threads, :title, :string, null: false, limit: 100
    change_column :forum_threads, :body, :text, null: false, limit: 20000
    change_column :forum_threads, :author_id, :bigint, null: false
    change_column :forum_threads, :forum_id, :bigint, null: false

    change_column :forums, :channel_id, null: false
  end
end
