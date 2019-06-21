module ProductsHelper
  def convert_name_catagories categories
    categories.each{|cate| cate.name = cate.name + " - " + cate.store.name}
  end

  def convert_catagories
    get_categories.pluck :name, :id
  end

  def get_statues
    Product.statuses.keys
  end

  def get_status_key product
    product.status
  end

  def get_categories
    if current_user.is_admin?
      categories = Category.select_id_and_name
      convert_name_catagories categories
    elsif current_user.is_manager?
      stores = current_user.stores
      categories = Category.IN_stores(stores).select_id_and_name
      convert_name_catagories categories
    end
    categories
  end
end
