class ProductsController < ApplicationController
  before_action :logged_in_user, only: %i(new create edit)
  before_action :load_product, only: %i(edit destroy)

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

  def destroy
    if @product.destroy
      flash[:success] = t "product.delete_success"
    else
      flash[:danger] = t "product.some_thing_was_wrong"
    end
    redirect_to request.referer
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end
end
