class UserController < ApplicationController
  def new

  end

  def update
  end

  def login
  	flash[:success] = 'Logged in'
  	redirect_to root_url
  end
end
