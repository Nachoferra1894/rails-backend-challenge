class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  has_secure_password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 6 }


  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end
end
