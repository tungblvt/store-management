class OrdersController < AdminsController
  before_action :load_store, only: %i(edit update)

  def index
    @orders = Order.includes(:user).references(:users).select("orders.*, users.name as user_name").page(params[:page]).per(Settings.order_per_page)
      .order_by_column :created_at
  end

  def edit; end

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
