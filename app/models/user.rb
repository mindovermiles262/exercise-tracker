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

  def User.losers
    # set 'limit' to monthly exercise count of 2nd from last user
    limit = User.monthly_count[-2][0] 
    losers = Array.new
    User.monthly_count.each do |arr|
      losers << arr if arr[0] <= limit
    end
    losers
  end

  def User.leaders
    # set 'limit' to monthly exercise count of 2nd place user
    limit = User.monthly_count[1][0]
    leaders = Array.new
    User.monthly_count.each do |arr|
      leaders << arr if arr[0] >= limit
      puts "#{arr[0]} limit: #{limit}"
    end
    leaders
  end

  private
  
  def downcase_email
    self.email = email.downcase
  end
  
  def User.monthly_count
    # Returns Array [Monthly Count, User Object] sorted by 
    # monthly exercise count high to low
    a = Array.new
    User.all.each do |user|
      if user.exercises.this_month.count > 0
        a << [user.exercises.this_month.count, user]
      end
    end
    a.sort.reverse!
  end
  end
