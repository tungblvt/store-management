class CategoriesController < AdminsController
  before_action :load_category, only: %i(edit update destroy show)
  before_action :have_permission

  def index
    if current_user.is_admin?
      @categories = Category.page(params[:page]).per(Settings.category_per_page)
        .order_by_column :name
      render "categories/index"
    elsif current_user.is_manager?
      @stores = current_user.stores
      @categories = Category.IN_stores(@stores).page(params[:page]).per(Settings.category_per_page)
        .order_by_column :name
      render "categories/index"
    else
      flash[:danger] = t "store.no_permission"
      redirect_to root_path
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.delete_success"
      redirect_to categories_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "category.update_successfully"
      redirect_to edit_category_url
    else
      render :edit
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

  def have_permission
    if current_user.is_member?
      render file: "#{Rails.root}/public/404", status: :not_found
    elsif current_user.is_manager?
      unless @category.nil?
        if @category.store.user.id != current_user.id
          render file: "#{Rails.root}/public/404", status: :not_found
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end
end
