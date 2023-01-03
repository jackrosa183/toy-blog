class CommentsController < ApplicationController

  before_action :correct_user, only: [:destroy]
  
  def new
    @comment = Comment.new
  end
  
  def create
    if params[:page] == ""
      page = 1
    else
      page = params[:page]
    end

    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @user.id
    @comment.post_id = @post.id 

    if params[:page] == ""
      page = 1
    else
      page = params[:page]
    end

    if @comment.save
      redirect_to controller: 'posts', 
                  action: 'show', 
                  id: @post.id
    else 
      redirect_to controller: 'posts',
                  action: 'show',
                  id: @post.id 
    end
  end


  def edit
  end

  def update
  end

  def destroy
    # debugger
    @post = Post.find(params[:post_id])

    @comment.destroy
    redirect_to controller: 'posts',
                action: 'show',
                id: @post.id,
                notice: "Comment was successfully destroyed"

  end

  private

  def correct_user
    @comment ||= Comment.find(params[:id])
    if @comment.user != current_user
      redirect_to posts_path
    else
      @comment
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :page)
  end

end