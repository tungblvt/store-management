class AdminsController < ApplicationController
  layout "admins", only: %i(home)

  def index; end

  def home; end
end
