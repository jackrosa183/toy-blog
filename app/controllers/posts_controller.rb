class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :update, :destroy, :edit]
  before_action :is_admin?, only: [:destroy]

  def index
    @posts = Post.published.paginate(page: params[:page], per_page: 3)
  end

  def index_drafts
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.publish_date == DateTime.current.to_date
      @post.published = true
    else
    end
    tags = post_params[:tag_titles].split(" ")

    puts "11111111111111111"
    puts tags 

    tags.each do |t|
      @post.tags << Tag.where(title: t).first_or_create
    end
      
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
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "Please login before continuing"
    else
      if is_admin?
        @post = Post.find(params[:id])
      else
        @post = Post.find(params[:id])          
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :user, 
                                  :publish_date, :tag, :tag_ids, :tag_titles, 
                                  :should_tweet, :should_fb_post)
  end

  def check_publishing
    @post = Post.find(params[:id])
    if @post.publish_date ==  DateTime.current.to_date
      @post.published = true
    else
      @post.published = false
    end
    @post.save
  end
end
