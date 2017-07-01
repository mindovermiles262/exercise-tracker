class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 6 }

  validates :name, presence: true, length: { maximum: 50 }

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

private

  def downcase_email
    self.email = email.downcase
  end

end
