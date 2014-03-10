class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] =  'Logged in'
      redirect_to :back
    else
      flash[:danger] = 'Invalid email or password'
      redirect_to :back
    end

  end

  def destroy 
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    redirect_to root_url
  end
end
