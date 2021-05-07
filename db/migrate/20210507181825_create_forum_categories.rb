class CreateForumCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_categories do |t|
      t.string :name, null: false
      t.integer :order

      t.timestamps
    end
  end
end
