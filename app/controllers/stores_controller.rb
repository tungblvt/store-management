class StoresController < AdminsController
  layout :dynamic_layout

  before_action :logged_in_user, except: %i(list detail)
  before_action :correct_user, only: %i(edit update destroy)
  before_action :load_store, only: %i(show edit update destroy detail)

  def index
    if current_user.is_admin?
      @stores = Store.page(params[:page]).per(Settings.store_per_page)
        .order_by_column :created_at
      render "stores/list"
    elsif current_user.is_manager?
      @stores = current_user.stores.page(params[:page]).per(Settings.store_per_page)
        .order_by_column :created_at
      render "stores/list"
    else
      flash[:danger] = t "store.no_permission"
      redirect_to root_path
    end
  end

  def new
    @store = Store.new
  end

  def create
    @store = current_user.stores.build store_params
    if @store.save
      flash[:success] = t "store.create_success"
      redirect_to stores_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @store.update store_params
      flash[:success] = t "store.edit_success"
      redirect_to stores_path
    else
      render :edit
    end
  end

  def show
    @category = Category.new
    @categories = @store.categories
    @product = Product.new
  end

  def detail
    @store = Store.find_by id: params[:id]
    @comment = Comment.new
    @comments = Store.joins_comments_user(@store.id).select_user_detail
    @order_detail = current_order.order_details.new
    if @store
      @categories = @store.categories
    else
      render file: "#{Rails.root}/public/404", status: :not_found
    end
  end

  def destroy
    if @store.destroy
      flash[:success] = t "store.destroy_success"
    else
      flash[:danger] = t "store.destroy_fail"
    end
    redirect_to stores_url
  end

  def lock
    @store = Store.find_by id: params[:id]
    if @store
      @store.lock_store
      respond_to do |format|
        format.html {redirect_to @store}
        format.js
      end
    end
  end

  def unlock
    @store = Store.find_by id: params[:id]
    if @store
      @store.unlock_store
      respond_to do |format|
        format.html {redirect_to @store}
        format.js
      end
    end
  end

  private

  def load_store
    @store = Store.find_by id: params[:id]
    return if @store
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def store_params
    params.require(:store).permit Store::STORE_PARAMS
  end

  def correct_user
    @store = current_user.stores.find_by(id: params[:id])
    redirect_to home_admin_path if @store.nil? && !current_user.is_admin?
  end

  def dynamic_layout
    case action_name
    when "detail", "search"
      "application"
    else
      "admins"
    end
  end
end
