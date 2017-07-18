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

  scope :top_2, -> {  includes(:exercises).references(:exercises)
                                      .order(exercise_count: :desc)
                                      .where("exercise_count > ? AND exercises.exercise_time > ? AND exercises.exercise_time < ?", 0 , Time.now.beginning_of_month, Time.now.end_of_month)
                                      .group_by{ |c| c.exercise_count }
                                      .take(2) }

  scope :bottom_2, -> {  includes(:exercises).references(:exercises)
                                      .order(exercise_count: :asc)
                                      .where("exercise_count > ? AND exercises.exercise_time > ? AND exercises.exercise_time < ?", 0 , Time.now.beginning_of_month, Time.now.end_of_month)
                                      .group_by{ |c| c.exercise_count }
                                      .take(2) }
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

private

  def downcase_email
    self.email = email.downcase
  end

end
