class UsersController < ApplicationController

    def create 
        @user = User.new(user_params)

        if @user.save
            render json: {"message" => "user created"} 
        else
            render json: {"error" => @user.errors.full_messages.to_sentence} 
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
