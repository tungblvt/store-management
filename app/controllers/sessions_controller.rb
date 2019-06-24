class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t "auth.login_success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if user.is_admin? || user.is_manager?
        redirect_to home_admin_path
      else
        redirect_to root_path
      end
    else
      flash[:danger] = t "auth.invalid_email_or_password_combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
