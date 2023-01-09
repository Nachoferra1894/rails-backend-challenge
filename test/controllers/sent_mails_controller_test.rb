require "test_helper"

class SentMailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sent_mail = sent_mails(:one)
  end

  test "should get index" do
    get sent_mails_url, as: :json
    assert_response :success
  end

  test "should create sent_mail" do
    assert_difference("SentMail.count") do
      post sent_mails_url, params: { sent_mail: { body: @sent_mail.body, receiver: @sent_mail.receiver, subject: @sent_mail.subject, user_id: @sent_mail.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show sent_mail" do
    get sent_mail_url(@sent_mail), as: :json
    assert_response :success
  end

  test "should update sent_mail" do
    patch sent_mail_url(@sent_mail), params: { sent_mail: { body: @sent_mail.body, receiver: @sent_mail.receiver, subject: @sent_mail.subject, user_id: @sent_mail.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy sent_mail" do
    assert_difference("SentMail.count", -1) do
      delete sent_mail_url(@sent_mail), as: :json
    end

    assert_response :no_content
  end
end
