class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "auth.p_login."
    redirect_to login_url
  end
end
