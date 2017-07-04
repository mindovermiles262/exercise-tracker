class AddCounterCacheToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :exercise_count, :integer, default: 0
  end
end
