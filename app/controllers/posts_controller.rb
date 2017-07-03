class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:index]

  def index
    @post = Post.paginate(page: params[:page], per_page: 10).order('created_at desc')
  end
  
  def new
  end
  
  def create
  end
  
end
