class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:index, :new, :create]

  def index
    @post = Post.paginate(page: params[:page], per_page: 10).order('created_at desc')
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(body: params[:post][:body], user_id: params[:post][:user])
    @post.save
    redirect_to(messages_path)
  end
  
private



end
