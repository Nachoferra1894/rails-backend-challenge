class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create, :login]
  load_and_authorize_resource

  # GET /users
  def index
    @pagy, @users = paginate(User.all)

    render json: @users
  end

    # GET /users/stats
    def stats
      users = User.all
      date = Time.zone.now
      users_with_emails_sent =  User.all.select {|user| user.emails_sent_on(date) > 0}
      @stats = users_with_emails_sent.map { |user| [user.username, user.emails_sent_on(date)] }

      render json: @stats
    end
  

  # GET /users/1
  def show
    render json: @user
  end

  # GET users/sent_mails
  def sent_mails
    @sent_mails = SentMail.where(user: current_user["id"])

    render json: @sent_mails
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
        token = encode_token(@user.id)
        session[:user_id] = @user.id
        render json: { user: @user, jwt: token }, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
        token = encode_token(@user.id)
        session[:user_id] = @user.id
        render json: { user: @user, jwt: token }, status: :ok
    else
        render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
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
