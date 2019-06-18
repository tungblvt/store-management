class ProductsController < ApplicationController
  before_action :logged_in_user, only: %i(new create edit)

  def new; end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "product.create_success"
      redirect_to stores_url
    else
      render :new
    end
  end

  def edit; end

  private

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end
end
