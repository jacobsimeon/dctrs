class SearchController < ApplicationController
  def index
    providers = Provider.search(params["query"], :page => (params[:page] || 1))
    @providers = ProviderDecorator.decorate(providers)
  end
end
