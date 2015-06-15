class ReviewsController < ApplicationController
  before_action :require_user
  before_action :admin_user, only: :destroy

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)
    @review.chef = current_user
    @reviews = @recipe.reviews.paginate(page: params[:page], per_page: 5) if @recipe.reviews.any?
    # binding.pry
    if @review.save
      flash[:success] = "Review was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'recipes/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    if @review.destroy
      flash[:success] =  "Recipe Deleted"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "There was an error deleting the review"
    end
  end

  private
    def review_params
      params.require(:review).permit(:body)
    end
end