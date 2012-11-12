class SearchController < ApplicationController
  respond_to :html, :json
  def index
    providers = Provider.search(params["query"], :page => (params[:page] || 1))
    @providers = ProviderDecorator.decorate(providers)
    respond_with @providers
  end
end
