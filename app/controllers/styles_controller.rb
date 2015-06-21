class StylesController < ApplicationController
  # index, show, new, edit, create, update, destroy
    before_action :require_user, except: :show
    before_action :admin_user, only: :destroy

  def show
    @style = Style.find(params[:id])
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "The style was created successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def destroy
    Style.find(params[:id]).destroy
    flash[:success] = "Style Deleted"
    redirect_to :back || root_path
  end

  private
    def style_params
      params.require(:style).permit(:name)
    end
end