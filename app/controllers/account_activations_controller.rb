# encoding: utf-8
# Account Activation Controller
class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      account_activated
    else
      account_not_activate
    end
  end

  private

  # return successful message when account activated.
  def account_activated
    user = User.find_by(email: params[:email])
    flash[:success] = 'Account activated!'
    redirect_to user
  end

  # return warning message when account not activate.
  def account_not_activate
    flash[:danger] = 'Invalid activation link'
    redirect_to root_url
  end
end
