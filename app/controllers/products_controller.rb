class ProductsController < AdminsController
  layout :dynamic_layout

  before_action :logged_in_user, except: %i(search search_by_cate)
  before_action :load_product, except: %i(index new create search search_by_cate)

  def index
    if current_user.is_admin?
      @categories = Category.pluck :id
      @products = Product.in_categories(@categories).page(params[:page])
        .per(Settings.product_per_page).order_by_column created_at: :desc
      render :index
    elsif current_user.is_manager?
      @stores = current_user.stores
      @categories = Category.IN_stores(@stores)
      @products = Product.in_categories(@categories).page(params[:page])
        .per(Settings.product_per_page).order_by_column created_at: :desc
      render :index
    else
      flash[:danger] = t "store.no_permission"
      redirect_to root_path
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "product.create_success"
      redirect_to products_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t "product.update_successfully"
      redirect_to products_path
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

  def search
    @order_detail = current_order.order_details.new
    @products = Product.search(params[:keyword]).product_available
      .page(params[:page]).per(Settings.product_per_page)
      .order_by_column :price
  end

  def search_by_cate
    @order_detail = current_order.order_details.new
    @category = Category.find_by id: params[:id]
    if @category
      @products = @category.products.page(params[:page]).product_available
        .per(Settings.product_per_page).order_by_column :price
      render :search
    else
      render file: "#{Rails.root}/public/404", status: :not_found
    end
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

  def dynamic_layout
    case action_name
    when "search", "search_by_cate"
      "application"
    else
      "admins"
    end
  end
end
