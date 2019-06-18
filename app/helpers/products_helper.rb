module ProductsHelper
  def convert_catagories categories
    categories.pluck :name, :id
  end
end
