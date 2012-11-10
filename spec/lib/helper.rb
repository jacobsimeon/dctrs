require 'rspec'
require 'factory_girl'
require 'factories/raw_taxonomy_factory'
require 'factories/raw_provider_factory'
require 'nppes/raw_provider'
require 'nppes/raw_taxonomy'
require 'json'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
