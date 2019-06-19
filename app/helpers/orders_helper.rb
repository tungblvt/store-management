module OrdersHelper
  def get_statuses
    Order.statuses.keys
  end

  def get_status_key order
    order.status
  end
end
