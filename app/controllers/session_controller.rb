class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t "auth.login_success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      render "static_pages/home"
    else
      flash[:danger] = t "auth.invalid_email_or_password_combination"
      render :new
    end
  end
end
