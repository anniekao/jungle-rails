class SessionsController < ApplicationController
  def new
  end

  def create
    if User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password invalid!"
      redirect_to '/login'
    end
  end

  def destory
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
