class SentMail < ApplicationRecord
  belongs_to :user
  validates :receiver, format: { with: URI::MailTo::EMAIL_REGEXP } , presence: true
  validates_presence_of :user, :subject, :body
  validate :validate_user_max_mails

  def validate_user_max_mails
    @user_mails = SentMail.where(user: user["id"], created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    max_mails = 1000
    if @user_mails.count >= max_mails
      errors.add(:user, "You can't send more than #{max_mails} mails per day")
    end
  end
end
