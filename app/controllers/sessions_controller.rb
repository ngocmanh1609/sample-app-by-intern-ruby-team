# encoding: utf-8
# Sessions controller
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user_activate
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def user_activate
    user = User.find_by(email: params[:session][:email].downcase)
    if user.activated?
      log_in user
      remember_checkbox
    else
      flash[:warning] = 'Account not activated. Check email for activate.'
      redirect_to root_url
    end
  end

  # remember or forget user
  def remember_checkbox
    user = User.find_by(email: params[:session][:email].downcase)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_back_or user
  end
end
