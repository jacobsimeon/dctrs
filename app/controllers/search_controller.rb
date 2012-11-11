class SearchController < ApplicationController
  def index
    providers = Provider.search(params["query"])
    @providers = ProviderDecorator.decorate(providers)
  end
end
