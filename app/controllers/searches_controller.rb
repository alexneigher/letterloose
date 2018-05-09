class SearchesController < ApplicationController

  def new
    @titles = Title.includes(:category).where('name ilike ? ', "#{params[:query]}%")
  end

end
