class UserMailer < ApplicationMailer
  def send_order user, order_id
    @user = user
    @order_id = order_id
    mail to: @user.email, subject: t("orders.new_order")
  end

  def send_order_user(user, order_details, address, total_price)
    @user = user
    @order_details = order_details
    @address = address
    @total_price = total_price
    mail to: @user.email, subject: t("orders.new_order")
  end
end
