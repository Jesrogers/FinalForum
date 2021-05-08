class AddDescriptionToForum < ActiveRecord::Migration[6.1]
  def change
    add_column :forums, :description, :string
  end
end
