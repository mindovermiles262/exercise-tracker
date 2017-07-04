class Exercise < ApplicationRecord
  belongs_to :user, counter_cache: :exercise_count
  default_scope -> { order(created_at: :desc) }
end
