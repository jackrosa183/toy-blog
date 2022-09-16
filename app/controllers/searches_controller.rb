class SearchesController < ApplicationController
  def index
    @tags = Tag.containing(params[:query])
  end
end