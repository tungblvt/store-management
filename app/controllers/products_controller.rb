class ProductsController < AdminsController
  before_action :logged_in_user
  before_action :load_product, except: %i(new create)

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

  def edit
    @store = Store.find_by id: params[:store_id]
    if @store
      @categories = @store.categories
    else
      flash[:danger] = t "product.cant_find_store"
      redirect_to stores_path
    end
  end

  def update
    if @product.update product_params
      flash[:success] = t "product.update_successfully"
      redirect_to stores_path
    else
      render :edit
    end
  end

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
