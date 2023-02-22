class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create, :login]
  load_and_authorize_resource

  attr_reader :users
  attr_accessor :user

  # GET /users
  def index
    @pagy, @users = paginate(User.all)

    render json: @users
  end

    # GET /users/stats
    def stats
      users = User.all
      date = Time.zone.now
      users_with_emails_sent =  User.with_today_sent_mails(date)
      @stats = users_with_emails_sent.map { |user| [user.username, user.emails_sent_on(date)] }

      render json: @stats
    end
  

  # GET /users/1
  def show
    render json: user
  end

  # GET users/sent_mails
  def sent_mails
    sent_mails = SentMail.where(user: current_user["id"])

    render json: sent_mails
  end

  # POST /users
  def create
    new_user = User.new(user_params)
    new_user.password = user_params[:password]
    if new_user.save
        token = encode_token(new_user.id)
        session[:user_id] = new_user.id
        render json: { user: new_user, jwt: token }, status: :created
    else
        render json: new_user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    search_user = User.find_by(email: params[:email])
    if search_user && search_user.authenticate(params[:password])
        token = encode_token(search_user.id)
        session[:user_id] = search_user.id
        render json: { user: search_user, jwt: token }, status: :ok
    else
        render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
end

  # DELETE /users/1
  def destroy
    user.destroy
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
