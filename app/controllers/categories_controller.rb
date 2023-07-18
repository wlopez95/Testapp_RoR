class CategoriesController < ApplicationController
  # before_action :set_category,only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category  = Category.new(category_params)
    if @category.save
      redirect_to  @category, notice: "Category was created successfully"
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    @category = Category.find(params[:id])
  end

  def index

  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
  def category_params
    params.require(:category).permit(:name)
  end


end
