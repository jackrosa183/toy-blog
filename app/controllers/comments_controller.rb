class CommentsController < ApplicationController

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to posts_path, notice: "Comment successfully created"
    else 
      redirect_to posts_path, alert: "Please enter content"
    end

  end

  def edit
  end

  def update
  end

  def destroy
    
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    @comment.destroy
    redirect_to posts_path, notice: "Comment was successfully destroyed"
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

end