
class UsersController < ApplicationController
  
  before_filter :check_session
  
    def create
      user = User.new(user_params)
        if user.save
          session[:_id] = user.id
          flash[:success] = "Your account was successfully created!"
          redirect_to '/'
        else
         flash[:danger] = user.errors.full_messages.join(". Also, ")
          redirect_to :back
        end
    end

    def new
      @user = User.new 
    end 

    def index
      @users = User.all 
    end

    def show
      @user = User.find(params[:id])
    end 

    def destroy 
     
    end 
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  
  end