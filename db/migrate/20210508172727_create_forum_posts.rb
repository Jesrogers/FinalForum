class CreateForumPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
