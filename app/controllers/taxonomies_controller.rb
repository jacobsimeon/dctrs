class TaxonomiesController < ApplicationController
  respond_to :json

  def index
    respond_with File.read('lib/data/specialties.json')
  end
end
