class ProvidersController < ApplicationController
  respond_to :html, :json
  def show
    @provider = Provider.find params[:id]
    respond_with @provider
  end
end
