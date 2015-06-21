class IngredientsController < ApplicationController
    before_action :require_user, except: :show
    before_action :admin_user, only: :destroy

  def show
    @ingredient = Ingredient.find(params[:id])
    @ingredients = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was added successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def destroy
    Ingredient.find(params[:id]).destroy
    flash[:success] =  "Ingredient Deleted"
    redirect_to :back || root_path
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

end