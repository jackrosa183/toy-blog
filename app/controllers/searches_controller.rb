class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
    render layout: false
    @title = params[:query]
    p @title.to_s + "!!!!!!"
  end

  def find_posts
    @tag = Tag.find_by('Lower(title)= ?', params[:query].downcase)
    unless @tag.nil?
      @posts = Post.tagged_with(@tag.title).or(Post.containing(params[:query])).paginate(page: params[:page], per_page: 3)
    else
      @posts = Post.containing(params[:query]).paginate(page: params[:page], per_page: 3)
    end
  end

  def find_users
    @users = User.where(User.arel_table[:email].matches("%#{params[:query]}%")).paginate(page: params[:page], per_page: 3)
  end
end