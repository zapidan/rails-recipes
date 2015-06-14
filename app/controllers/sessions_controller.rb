class SessionsController < ApplicationController

  def new
  end

  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are logged in"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Your email address or password did not match"
      render 'new'
    end
  end

  def destroy
    if session[:chef_id]
      session[:chef_id] = nil
      flash[:success] = "You have logged out successfully"
    else
      flash[:warning] = "You are not logged in"
    end
    redirect_to root_path
  end
end