class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
    render layout: false
    @title = params[:query]
    p @title.to_s + "!!!!!!"
  end

  def find_posts
    @posts = Post.containing(params[:query])
    render json: @posts
  end
end