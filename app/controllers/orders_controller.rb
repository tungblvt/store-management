class OrdersController < AdminsController
  def index
    @orders = Order.includes(:user).references(:users).select("orders.*, users.name as user_name").page(params[:page]).per(Settings.order_per_page)
      .order_by_column :created_at
  end
end
