class HeadersController < ApplicationController
  respond_to :json

  def index
    respond_with File.read('lib/data/raw_provider_headers.json')
  end
end
