class IngredientsController < ApplicationController
    before_action :set_ingredient, only: [:show, :destroy]
    before_action :require_user, except: :show
    before_action :admin_user, only: :destroy

  def show
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.name = @ingredient.name.to_s.capitalize
    if @ingredient.save
      flash[:success] = "Ingredient was added successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def destroy
    @ingredient.destroy
    flash[:success] =  "Ingredient Deleted"
    redirect_to recipes_path || root_path
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

end