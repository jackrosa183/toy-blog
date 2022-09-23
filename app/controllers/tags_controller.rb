class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.title)
  end
 
  def add
    @tag = Tag.find(params[:id])
    puts @tag.title
  end
end