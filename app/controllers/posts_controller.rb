class PostsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @posts= Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created"
    else
      render :new
    end
  end 

  def edit
  end

  def update
  end

  def destroy
    @post.destroy
  end

  private
  
  
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
