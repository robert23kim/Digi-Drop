class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Logged in!"
    else
      redirect_to login_path, notice: "Username or password is invalid"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "Logged out!"
  end
end