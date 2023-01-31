ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as_admin
    @user = users(:one)
    post '/users/login', params: { email: @user.email, password: @user.username}, as: :json
    assert_response :ok
    exp = Time.now.to_i + 24 * 3600
    user = JSON.parse(@response.body)["user"]
    User.find(user["id"]).add_role :admin

    payload = { user_id: user["id"], exp: exp }
    JWT.encode(payload, ENV['JWT_SECRET'])
  end
end
