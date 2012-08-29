class SearchController < ApplicationController
  def index
    @providers = Provider.search(params)
  end
end
