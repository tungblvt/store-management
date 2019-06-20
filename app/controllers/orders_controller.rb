class OrdersController < AdminsController
  before_action :load_store, only: %i(edit update show)

  def index
    if current_user.is_admin?
      @orders = Order.includes(:user).references(:users).select("orders.*, users.name as user_name").page(params[:page]).per(Settings.order_per_page)
                    .order_by_column :created_at
      render "orders/index"
    elsif current_user.is_manager?
      stores = current_user.stores
      @orders = Order.IN_stores(stores).includes(:user).references(:users).select("orders.*, users.name as user_name").page(params[:page]).per(Settings.order_per_page)
                    .order_by_column :created_at
      render "orders/index"
    else
      flash[:danger] = t "store.no_permission"
      redirect_to static_pages_home_path
    end
  end

  def edit; end

  def show
    @order_details = Order.joins_order_details_products(@order.id).select_order_detail
  end

  def update
    if @order.update orders_params
      flash[:success] = t "orders.update_successfully"
      redirect_to edit_order_url(@order)
    else
      render :edit
    end
  end

  private

  def load_store
    @order = Order.find_by id: params[:id]
    return if @order
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def orders_params
    params.require(:order).permit Order::ORDER_PARAMS
  end
end
