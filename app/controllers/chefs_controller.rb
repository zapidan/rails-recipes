class ChefsController < ApplicationController
  # index, show, new, edit, create, update, destroy

  before_action :set_chef, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 4)
  end

  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @chef = Chef.new
  end

  def edit
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account has been created successfully"
      session[:chef_id] = @chef.id
      redirect_to recipes_path
    else
      flash[:danger] = "There was a problem creating your account"
      render 'new'
    end
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end

  private
    def chef_params
      params.require(:chef).permit(:chefname, :password, :email)
    end

    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end
end