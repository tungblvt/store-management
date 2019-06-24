class AdminsController < ApplicationController
  layout "admins", only: %i(home)

  def home
    redirect_to stores_path
  end
end
