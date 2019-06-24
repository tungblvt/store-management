class OrdersController < AdminsController
  layout :dynamic_layout

  before_action :logged_in_user
  before_action :load_store, only: %i(edit update show)
  before_action :load_items, only: :checkout

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
      redirect_to root_path
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

  def checkout; end

  def post_checkout
    @order_details = current_order.order_details
    @order_id = @order_details.first[:order_id]
    @order = Order.find_by id: @order_id
    @user = @order.user
    total_price = @order.subtotal
    UserMailer.send_order(@user, @order_id).deliver_now
    UserMailer.send_order_user(@user, @order_details, params[:address], total_price).deliver_now
    flash[:info] = t "orders.noti_send_mail"
    session[:order_id] = nil
    redirect_to root_url
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

  def dynamic_layout
    case action_name
    when "user_order", "cart", "checkout", "post_checkout"
      "application"
    else
      "admins"
    end
  end

  def load_items
    @order_details = current_order.order_details
    return if @order_details.size > 0
    redirect_to root_path
  end
end
