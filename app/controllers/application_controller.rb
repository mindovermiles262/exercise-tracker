class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def 

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
