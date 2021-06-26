class AddModifiersToForumReplies < ActiveRecord::Migration[6.1]
  def change
    change_column :forum_replies, :body, :text, null: false, limit: 20000
    change_column :forum_replies, :author_id, :bigint, null: false
    change_column :forum_replies, :forum_thread_id, :bigint, null: false
  end
end
