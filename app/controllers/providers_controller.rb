class ProvidersController < ApplicationController
  def show
    @provider = Provider.find params[:id]
    raise ActionController::RoutingError.new('Not Found') unless @provider
    raise @provider.to_yaml
  end
end
