class SessionsController < ApplicationController
  
  before_filter :check_session, only: [:new, :create]


  def new
    @user = User.new
  end

 def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

 def authorize
    redirect_to '/register' unless current_user
  end
  
    def create
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome back, #{user.first_name}!"
        redirect_to '/'
      else
        flash[:danger] = "We couldn't log you in. Please verify that your email/password is correct."
        redirect_to :back
      end
    end
  
    def destroy
      if current_user.nil?
        flash[:warning] = "You aren't logged in."
        redirect_to '/'
      else
        session[:user_id] = nil
        flash[:warning] = "You have successfully logged out"
        redirect_to '/'
      end
    end
  
  end

