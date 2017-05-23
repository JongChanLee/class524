class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    post = Post.new
    post.title = params[:title]
    post.user = current_user
    post.save
    
    redirect_to "/posts/show/#{post.id}"
  end

  def show
  end

  def edit
  end

  def update
    @post.title = params[:title]
    @post.save
    
    redirect_to "/posts/show/#{@post.id}"
  end

  def destroy
    @post.destroy
    
    redirect_to "/posts/index"
  end
  
  private
  def get_post
    @post = Post.find(params[:post_id])
  end
  
  def authorize_user
    unless @post.user.email == current_user.email
      redirect_to "/posts/show/#{@post.id}"
    end
  end
end
