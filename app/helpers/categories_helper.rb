module CategoriesHelper
  def stores
    current_user.stores
  end

  def stores_option_for_select
    stores.pluck :name, :id
  end
end
