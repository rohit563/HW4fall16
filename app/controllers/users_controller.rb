class UsersController < ApplicationController

    def user_params
        params.require(:user).permit(:user_id, :email, :session_token)
    end
    
    def index
        @users = User.all
    end
    
    def show
        id = params[:id] # retrieve movie ID from URI route
        @user = User.find(id) # look up movie by unique ID
        # will render app/views/movies/show.<extension> by default
    end
    
    def create
        @user = params[:user_id] # retrieve movie ID from URI route
        if (User.exists?(:user_id => user_params[:user_id]))
            flash[:notice] = "Sorry this user_id is taken. Try again."
            redirect_to new_user_path

        else
            User.create_user!(user_params)
            flash[:notice] = "Welcome #{user_params[:user_id]}. You account has been created."
            redirect_to login_path
        end

    end
    
    def new
        # default: render 'new' template
    end
    
end
