class CategoriesController < AdminsController
  before_action :load_category, only: %i(destroy)

  def index
    @categories = Category.page(params[:page]).per(Settings.category_per_page)
      .order_by_column :name
  end

  def new; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.delete_success"
      redirect_to stores_url
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.delete_success"
    else
      flash[:danger] = t "category.some_thing_was_wrong"
    end
    redirect_to categories_url
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  private

  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end
end
