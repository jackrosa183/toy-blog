class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
    render layout: false
    @title = params[:query]
    p @title.to_s + "!!!!!!"
  end

  def find_posts
    @tag = Tag.find_by('Lower(title)= ?', params[:query].downcase)
    if @tag.nil?
      @posts = Post.containing(params[:query]).paginate(page: params[:page], per_page: 3)
    else 
      @posts = Post.tagged_with(@tag.title).paginate(page: params[:page], per_page: 3)
    end
    # render json: @posts
  end
end