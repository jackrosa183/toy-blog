class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
    render layout: false
    @title = params[:query]
    p @title + "!!!!!!"
  end
end