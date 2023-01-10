class User < ApplicationRecord
  rolify
  has_many :sent_mails
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

  def loged_in?
    has_role?(:user)
  end

  def emails_sent_on(date)
    sent_mails.where("created_at >= ? AND created_at <= ?", date.beginning_of_day, date.end_of_day).count
  end
end
