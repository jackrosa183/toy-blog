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
    # @staged_tags = []
    tags = post_params[:extracted_tags]
    if @post.publish_date = DateTime.current
      @post.published = true
    else
    end
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created"
    else
      redirect_to new_post_path, alert: @post.errors.full_messages
    end
  end 

  def edit
    @staged_tags = []
    @post.tags.each do |st|
      @staged_tags << st
    end
    
    @editing = true
    @post.tags = []
    # debugger 
  end

  def update

    if @post.published = true
      edit_params = params.require(:post).permit(:title, :content, :user, extracted_tags: [])
    else
      edit_params = post_params
    end

    tags = edit_params[:extracted_tags]
    
    if @post.update(edit_params)
      redirect_to posts_path, notice: "Post was successfully updated"
    else
      redirect_to edit_post_path, alert: @post.errors.full_messages
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path, notice: "Post was successfully destroyed"
  end

  private
  
  def set_post
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Please login before continuing"
    else
      if is_admin?
        @post = Post.find(params[:id])
      else
        @post = Post.find(params[:id])          
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :rich_content, :user, 
                                  :publish_date, 
                                  :should_tweet, extracted_tags: [])
  end
end