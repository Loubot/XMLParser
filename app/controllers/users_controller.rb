class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def update
  end  

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'User created'
      login_user(@user)      
    else
      render 'new'
    end

  end

  def show
    @user = User.find_by_id(params[:id])
    @favourites = @user.favourites
    
    
  end
end
