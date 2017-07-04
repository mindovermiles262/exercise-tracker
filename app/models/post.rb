class Post < ApplicationRecord
  belongs_to :user, counter_cache: :posts_count
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :body, presence: true
end
