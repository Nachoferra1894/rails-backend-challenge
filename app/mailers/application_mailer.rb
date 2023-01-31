class ApplicationMailer < ActionMailer::Base
    layout "mailer"
    private
        def mail_params
            params.permit(:user_id,:receiver,:subject,:body)
        end
        def get_mail(user_id)
            @user = User.find(user_id)
            return false, 'Invalid user' if @user.nil?
            return true, @user.email
        end
end
