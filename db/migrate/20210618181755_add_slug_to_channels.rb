class AddSlugToChannels < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :slug, :string
    add_index :channels, :slug, unique: true
  end
end
