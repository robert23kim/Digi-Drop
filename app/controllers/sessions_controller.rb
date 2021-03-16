class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    @keyword = params[:password_digest]
    #byebug
    if !!@user && @user.authenticate(@keyword)
      session[:user_id] = @user.id
      redirect_to users_path, notice: "Logged in!"
    else
      redirect_to login_path, notice: "Username or password is invalid"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "Logged out!"
  end
end