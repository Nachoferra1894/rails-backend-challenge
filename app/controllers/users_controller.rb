class UsersController < ApplicationController
  before_action :set_user, :authenticate_request, except: [:create, :login]
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
        token = encode_token(@user.id)
        render json: { user: @user, jwt: token }, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    @user = User.find_by(email: params[:email])

    if @user.authenticate(params[:password])
        token = encode_token(@user.id)
        render json: { user: @user, jwt: token }, status: :ok
    else
        render json: { error: 'Invalid username or password' }, status: :unprocessable_entity
    end
end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
