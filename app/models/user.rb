class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :posts,      dependent: :destroy
  has_many :exercises,  dependent: :destroy

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, presence: true, length: { maximum: 50 }

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }



  
  # Returns hash digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  scope :exercises_this_month, -> {  includes(:exercises).references(:exercises)
    .where("exercise_count > ? AND exercises.exercise_time > ? AND exercises.exercise_time < ?", 
    0 , Time.now.beginning_of_month, Time.now.end_of_month) 
  }

  def User.losers
    limit = User.exercises_this_month.where("exercise_count > ?", 0).order(exercise_count: :asc).second.exercise_count
    User.exercises_this_month.where("exercise_count > ? AND exercise_count <= ?", 0, limit)
  end

  def User.leaders
    limit = User.exercises_this_month.where("exercise_count > ?", 0).order(exercise_count: :desc).second.exercise_count
    User.exercises_this_month.where("exercise_count > ? AND exercise_count >= ?", 0, limit)
  end

private

  def downcase_email
    self.email = email.downcase
  end

end
