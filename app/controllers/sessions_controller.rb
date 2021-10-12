class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

        if user
            session[:user_id] = user.id
            payload = { user_id: user.id }
            render json: {
                token: JWT.encode(payload, nil, 'HS256')
            }
        else
            render json: {
                status: 401,
                "error": "Invalid Email or Password"
            }
        end
    end
end
