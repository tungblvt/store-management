class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t "auth.login_success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if user.is_admin?
        redirect_to admins_home_path
      else
        render "static_pages/home"
      end
    else
      flash[:danger] = t "auth.invalid_email_or_password_combination"
      render :new
    end
  end
end
