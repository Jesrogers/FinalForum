class ChangeStickiedDefaultToFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default :forum_threads, :stickied, false
  end
end
