class UserController < ApplicationController
  def new

  end

  def update
  end

  def login
  	flash.keep[:error] = "well done"
  	redirect_to root_url
  end
end
