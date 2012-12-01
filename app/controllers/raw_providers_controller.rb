require 'csv'
require 'json'

class RawProvidersController < ApplicationController
  http_basic_authenticate_with :name => "jacob", :password => "simeon"

  def create
    provider = Provider.create(get_raw_provider_from_string)
    render :text => "created provider #{provider.npi}", status: :created
  end

  private
  def get_raw_provider_from_string
    options = { headers: csv_headers, header_converters: :symbol }
    values = CSV.parse_line params[:raw_provider], options

    raw_provider = Nppes::RawProvider.new(values.to_hash, taxonomies).to_hash
  end

  def taxonomies
    @taxonomies ||= JSON.parse(File.read('lib/data/specialties.json'))
  end

  def csv_headers
    @headers ||= JSON.parse(File.read('lib/data/raw_provider_headers.json'))
  end

end

