class AddStickiedToForumThread < ActiveRecord::Migration[6.1]
  def change
    add_column :forum_threads, :stickied, :boolean
  end
end
