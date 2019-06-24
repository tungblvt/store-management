class HomesController < ApplicationController
  def index
    @categories = Category.select_id_and_name.limit(Settings.category.limit_home)
    @stores = Store.select_store_id_and_name_and_address.store_active.store_lock.limit(Settings.store.limit_home)
    @order_item = current_order.order_details.new
  end
end
