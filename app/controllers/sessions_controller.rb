class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are signed in!'
      redirect_to bugs_path
    else
      flash[:danger] = "Invalid email or password. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end
end