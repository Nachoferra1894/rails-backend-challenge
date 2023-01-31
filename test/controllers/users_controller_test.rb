require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @password = 'MyString'
  end

  test "should not get index for non-signed in user" do
    get users_url, as: :json
    assert_response :unauthorized
  end

  test "should not create user with repeated email" do
    post users_url, params: { user: { email: @user.email, password: @user.password_digest, username: @user.username } }, as: :json

    assert_response :unprocessable_entity
    assert_equal "has already been taken", JSON.parse(@response.body)["email"][0]
  end

  test "should create user" do
    post users_url, params: { user: { email: @user.email + '1', password: @user.password_digest, username: @user.username } }, as: :json

    assert_response :created
    user = JSON.parse(@response.body)["user"]
    assert_equal@user.username, user["username"]
    assert_equal @user.email + '1', user["email"]
    assert_not_equal @password, user["password_digest"]
  end

  test "should login user" do
    post users_url, params: { user: { email: @user.email + '1', password: @password, username: @user.username } }, as: :json

    assert_response :created

    post '/users/login', params: { email: @user.email + '1', password: @password }, as: :json

    assert_response :ok
    user = JSON.parse(@response.body)["user"]
    assert_equal @user.username, user["username"]
    assert_equal @user.email+'1' , user["email"]
    assert_not_equal @password, user["password_digest"]
  end

  test "should show user for authenticated user" do
    token = login_as_admin

    get user_url(@user), as: :json, headers: {
      'Authorization': "Bearer #{token}"
    }
    assert_response :success
  end

end
