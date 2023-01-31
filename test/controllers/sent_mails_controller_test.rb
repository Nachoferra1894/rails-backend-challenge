require "test_helper"

class SentMailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sent_mail = sent_mails(:one)
  end

  test "should get index for admin users" do
    token = login_as_admin
    get sent_mails_url, as: :json, headers: {
      'Authorization': "Bearer #{token}"
    }
    assert_response :success
  end

  test "should not create sent_mail for invalid mail" do
    token = login_as_admin
    post sent_mails_url, 
      params: { mail: { body: @sent_mail.body, receiver: @sent_mail.subject, subject: @sent_mail.subject } }, 
      as: :json,
      headers: { 'Authorization': "Bearer #{token}" }

    assert_response :unprocessable_entity
  end

  test "should create sent_mail" do
    token = login_as_admin
    send_email(token)

    assert_response :created
  end

  test "should not create sent_mail for more than 1000" do
    token = login_as_admin
    @user = users(:one)
    (0..999).each do |i|
      SentMail.create(user: @user,body: "body #{i}", receiver: "receiver#{i}@mail.com", subject: "subject #{i}")
    end

    send_email(token)
    assert_response :unprocessable_entity
  end

  private 
    def send_email(token)
      post sent_mails_url, 
        params: { mail: { body: @sent_mail.body, receiver: @sent_mail.receiver, subject: @sent_mail.subject } }, 
        as: :json,
        headers: { 'Authorization': "Bearer #{token}" }
    end
end
