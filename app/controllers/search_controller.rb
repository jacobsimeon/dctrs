class SearchController < ApplicationController
  def index
    @providers = Provider.search(params["query"])
  end
end
