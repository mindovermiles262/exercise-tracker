class Exercise < ApplicationRecord
  belongs_to :user, counter_cache: :exercise_count
  default_scope -> { order(created_at: :desc) }

  scope :this_month, -> { includes(:exercises).where("exercise_time < ? AND exercise_time > ?", Time.now.end_of_month, Time.now.beginning_of_month) }
end
