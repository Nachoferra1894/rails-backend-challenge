class ApplicationController < ActionController::API
    include ActionController::Helpers
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    include Pagy::Backend
    before_action :set_session
    
    
    def paginate(records)
        pagy(records, items: params[:page_size] || 10)
    end

    def encode_token(user_id)
        exp = Time.now.to_i + 3600

        # create the payload with the user_id and expiry time
        payload = { user_id: user_id, exp: exp }
        JWT.encode(payload, ENV['JWT_SECRET'])
    end

    def authenticate_request
        # get the JWT from the request headers
        auth_header = request.headers['Authorization']
        if auth_header
        # extract the JWT from the "Bearer" scheme
        token = auth_header.split(' ').last
        begin
            # decode the JWT and check the expiry date
            decoded_token = JWT.decode(token, ENV['JWT_SECRET'])
            # check that the JWT has not expired
            if Time.at(decoded_token[0]['exp']) < Time.now
            render json: { error: 'Token has expired' }, status: 401
            end
        rescue JWT::DecodeError
            render json: { error: 'Invalid token' }, status: 401
        end
        else
            render json: { error: 'No token provided' }, status: 401
        end
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
 
    private
        def set_session
            cookies["CSRF-TOKEN"] = {
                value: form_authenticity_token,
                domain: :all 
            }
        end

end
