class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,    only: [:edit, :update, :destroy]
  # before_action :admin_user,      only: [:destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = "Welcome, #{@user.name}!"
      redirect_to root_url
    else
      # Errors rendered by '_users_form'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User Profile Successfully Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end



end
