class ChangeLockedDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :forums, :locked, from: true, to: false
  end
end
