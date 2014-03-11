class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def update
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user 
      flash[:success] = 'Logged in'
      redirect_to root_url
    else 
      flash[:danger] = 'Invalid email or password'
      redirect_to root_url
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'User created'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def addFavourite
    flash[:success] = params[:name]
    redirect_to :back
  end

  def show
    @user = User.find_by_id(params[:id])
    @favourites = @user.favourites
    
    
  end
end
