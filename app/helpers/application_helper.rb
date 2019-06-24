module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t("title")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def current_order store_id = Settings.id_unavailable
    if session[:order_id].present?
      Order.find session[:order_id]
    else
      if store_id >= 0
        Order.new store_id: store_id.to_s, user_id: current_user.id
      else
        Order.new
      end
    end
  end
end
