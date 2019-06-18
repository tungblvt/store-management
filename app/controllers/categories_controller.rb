class CategoriesController < AdminsController
  def index; end

  def new; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "store.create_success"
      redirect_to stores_url
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end
end
