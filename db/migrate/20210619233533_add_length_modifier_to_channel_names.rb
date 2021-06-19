class AddLengthModifierToChannelNames < ActiveRecord::Migration[6.1]
  def change
    change_column :channels, :name, :string, limit: 40
    change_column_default :channels, :position, 1 
  end
end
