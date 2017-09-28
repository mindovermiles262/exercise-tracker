class Exercise < ApplicationRecord
  belongs_to :user, counter_cache: :exercise_count
  default_scope -> { order(created_at: :desc) }

  scope :this_month, -> { 
    where("exercise_time < ? AND exercise_time > ?", 
      Time.now.end_of_month, Time.now.beginning_of_month) 
  }

  def Exercise.last_exercise(user)
    user.exercises.exists? ? user.exercises.first.created_at : (Time.current - 3600)
  end
end
