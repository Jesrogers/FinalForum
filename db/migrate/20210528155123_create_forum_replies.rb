class CreateForumReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_replies do |t|
      t.text :body
      t.references :forum_thread, foreign_key: true
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
