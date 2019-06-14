class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "auth.sign_up.singup_success"
      redirect_to static_pages_home_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
