class RecipesController < ApplicationController
  # index, show, new, edit, create, update, destroy
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def show
    #binding.pry
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)  
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "There was a problem creating your recipe" 
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    like = params[:like]
    @like = Like.create(like: like, recipe: @recipe, chef: @recipe.chef)
    if @like.valid?
      flash[:success] = "Your selection was successful"
    else
      flash[:warning] = "You can only like/dislike once"
    end
    redirect_to :back
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end

    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
      end
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
end