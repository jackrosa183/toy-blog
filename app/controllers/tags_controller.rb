class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.title)
  end
  
  def add
    @post = Post.find(params[:post_id])
    @tag = Tag.find(params[:id])
  end
  
end