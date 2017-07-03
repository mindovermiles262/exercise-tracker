class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:index]

  def index
    @post = Post.order('created_at desc').limit(5)
  end
  
  def new
  end
  
  def create
  end
  
end
