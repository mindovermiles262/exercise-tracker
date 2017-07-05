class AddDatetimeToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :exercise_time, :datetime
  end
end
