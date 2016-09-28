class SessionsController < ApplicationController
    
    def user_params
        params.require(:user).permit(:user_id, :email, :session_token)
    end
    
    def new
 
    end

    def create
        if ((User.exists?(:user_id => user_params[:user_id])) && (User.exists?(:email => user_params[:email])))
            flash[:notice] = "You are logged in as #{user_params[:user_id]}"
            @user = User.find_by(user_params)
            # @email = User.find_by(user_params)
            session[:session_token] = @user.session_token
            @current_user ||= session[:session_token ] && User.find_by_session_token(session[:session_token])
            redirect_to movies_path

        else
            flash[:notice] = "invalid user-id/email combination"
            
            redirect_to login_path

        end
    end
    
    def destroy
        flash[:notice] = "Logged Out"
        session[:session_token] = nil
        redirect_to movies_path
    end
end
