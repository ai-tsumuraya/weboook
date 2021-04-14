class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :stores]

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Signed up successfully'
      redirect_to @user
    else
      flash.now[:danger] = 'Failed to create an account.'
      render :new
    end
  end
  
  def saves
    @user = User.find(params[:id])
    @stores = @user.stores.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
