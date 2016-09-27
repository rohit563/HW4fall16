class UsersController < ApplicationController

    def user_params
        params.require(:user_id, :email)
    end

    
    def create
        user_id = params[:user_id] # retrieve movie ID from URI route
        if(Movie.find(user_id) == nil)
            @user = User.create!(user_params)
            @session_token = SecureRandom.base64
            flash[:notice] = "Welcome #{@user.title}. You account has been created."
            redirect_to new_user_path
        else
            flash[:notice] = "Sorry, #{@user.title} is taken. Try again."
        end

    end
    
    def new
    end
end
