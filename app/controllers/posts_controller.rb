class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:index, :new, :create]

  def index
    @post = Post.paginate(page: params[:page], per_page: 10).order('created_at desc')
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to(messages_path)
  end
  
private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

end
