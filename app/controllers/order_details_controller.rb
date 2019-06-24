class OrderDetailsController < ApplicationController
  def create
    if logged_in?
      @order = current_order params[:order_detail][:store_id].to_i
      @order_detail = @order.order_details.new order_detail_params
      if @order.save
        session[:order_id] = @order.id
      else
        flash[:danger] = t "orders.can_not_order"
        redirect_to request.referer
      end
    else
      flash[:danger] = t "auth.p_login"
      redirect_to login_path
    end
  end

  def update
    @order = current_order
    @order_detail = @order.order_details.find_by id: params[:id]
    @order_detail.update order_detail_params
    @order_details = @order.order_details
  end

  def destroy
    @order = current_order
    @order_detail = @order.order_details.find_by id: params[:id]
    @order_detail.destroy
    @order_details = @order.order_details
  end

  private

  def order_detail_params
    params.require(:order_detail).permit OrderDetail::ORDER_DETAIL_PARAMS
  end
end
