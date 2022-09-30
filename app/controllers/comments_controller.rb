class CommentsController < ApplicationController

  # before_action :correct_user, only: [:create, :destroy]
  
  def new
    @comment = Comment.new
  end
  
  def create
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
                  action: 'index', 
                  page: page
    else 
      redirect_to controller: 'posts',
                  action: 'index',
                  page: page
    end
  end


  def edit
  end

  def update
  end

  def destroy
    # debugger
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    @comment.destroy
    redirect_to controller: 'posts',
                action: 'index',
                page: params[:page],
                notice: "Comment was successfully destroyed"

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :page)
  end

end