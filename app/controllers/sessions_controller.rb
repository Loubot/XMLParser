class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    login_user(user)

  end

  def destroy 
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    redirect_to root_url
  end
end
