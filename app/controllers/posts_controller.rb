class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:set_post, :index, :show, :new, :create, :update, :destroy]
  before_action :is_admin?, only: [:destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created"
    else
      flash[:alert] = "Post must have title and content"
      render :new
    end
  end 

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path, notice: "Post was successfully destroyed"
  end

  private
  
  def set_post
    if is_admin?
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find(params[:id])          
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :user)
  end

end
