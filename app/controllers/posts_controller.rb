class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:index]

  def index
    @post = Post.order('created_at desc').limit(5)
  end
  
  def new
  end
  
  def create
  end

private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In"
      redirect_to login_url
    end
  end
  
end
