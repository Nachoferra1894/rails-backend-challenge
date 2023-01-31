class RailsMailer < ApplicationMailer
  def send_email(mail_params)
    @params = mail_params
    mail = get_mail(@params[:user_id])
    mail(from: mail ,to: @params[:receiver], subject: @params[:subject], body: @params[:body])
  end 
end
