module OrdersHelper
  def get_statuses
    Order.statuses.keys
  end

  def get_status_key order
    order.status
  end

  def get_total_money order_details
    total_money = 0
    order_details.each do |order_detail|
      total_money += order_detail.total.to_i
    end
    total_money
  end
end
