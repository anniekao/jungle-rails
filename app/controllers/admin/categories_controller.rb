class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    raise @category.inspect
    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(name: params[:category][:name])
    redirect_to [:admin, :categories], notice: 'Category edited!'
  end

  private
  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
