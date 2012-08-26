class SearchController < ApplicationController
  def index
    @providers = Provider.where "name LIKE ?", "%#{params[:query]}%"
  end
end
