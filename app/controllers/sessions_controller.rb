class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
        if user
            render json: {
                token: token(user.id)
            }
        else
            render json: {
                status: 401,
                "error": "Invalid Email or Password"
            }
        end
    end
end
