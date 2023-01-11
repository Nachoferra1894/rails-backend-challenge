require 'mailgun-ruby'

class MailgunMailer < ApplicationMailer
    def send_email(mail_params)
        api_key = ENV['MAILGUN_API_KEY']
        domain_key = ENV['MAILGUN_DOMAIN_KEY']

        puts "API KEY: #{api_key}"
        puts "DOMAIN KEY: #{domain_key}"

        mg_client = Mailgun::Client.new api_key
        @params = mail_params
        mail = get_mail(@params[:user_id])

        message_params =  { 
            from: mail,
            to:   @params[:receiver],
            subject: @params[:subject],
            text:    @params[:body]
        }
        @mail_sent = mg_client.send_message domain_key, message_params
    end
end
