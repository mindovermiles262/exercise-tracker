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
    if @post.save
      flash[:success] = "Message Created"
      redirect_to(messages_path)
    else
      flash[:danger] = "Could not Create Message"
      redirect_to new_post_path
    end
  end
  
private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

end
