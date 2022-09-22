class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
    render layout: false
  end
end