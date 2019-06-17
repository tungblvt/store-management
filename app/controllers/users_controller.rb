class UsersController < ApplicationController
  before_action :is_admin, only: %i(index destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.page(params[:page]).per(Settings.user_per_page)
      .order_by_column :name
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

  def destroy
    @user = User.find_by id: params[:id]
    if @user
      if @user.destroy
        flash[:success] = t "list_users.delete_successfully"
        redirect_to users_url
      else
        flash[:danger] = t "list_users.some_thing_was_wrong"
      end
    else
      redirect_to static_pages_home_path
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def is_admin
    return if current_user.role == Settings.role.admin
    redirect_to static_pages_home_url
  end
end
