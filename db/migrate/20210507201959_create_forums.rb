class CreateForums < ActiveRecord::Migration[6.1]
  def change
    create_table :forums do |t|
      t.string :title
      t.integer :order
      t.boolean :locked, default: true
      t.string :author

      t.timestamps
    end
  end
end
