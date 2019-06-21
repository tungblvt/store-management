module CategoriesHelper
  def stores
    if current_user.is_admin?
      Store.all
    else
      current_user.stores
    end
  end

  def stores_option_for_select
    stores.pluck :name, :id
  end
end
