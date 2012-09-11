class SearchController < ApplicationController
  def index
    @providers = Provider.search(params["query"], load: true)
  end
end
