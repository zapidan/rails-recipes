class RecipesController < ApplicationController
  # index, show, new, edit, create, update, destroy

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def show
    @recipe = Recipe.find(params[:id])
    #binding.pry
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)  
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "There was a problem creating your recipe" 
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    @recipe = Recipe.find(params[:id])
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
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end