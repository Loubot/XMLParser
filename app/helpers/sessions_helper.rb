module SessionsHelper

  def login_user(user)
    if user
      session[:user_id] = user.id
      flash[:success] =  'Logged in'
      redirect_to root_url
    else
      flash[:danger] = 'Invalid email or password'
      redirect_to :back
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
