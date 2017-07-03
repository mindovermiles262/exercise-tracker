class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :exercises [:user_id, :created_at]
  end
end
