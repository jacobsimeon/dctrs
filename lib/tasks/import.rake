task :import do

  require 'csv'
  require 'json'
  require './lib/nppes/raw_provider.rb'

  puts "Starting..."

  providers = []
  CSV.foreach("tmp/mini_providers.csv", :headers => true, :header_converters => :symbol) do |row|
    "Parsing provider"
    providers.push Nppes::RawProvider.new(row.to_hash).to_hash
  end

  File.open('tmp/mini_provider.json', 'w+') do |f|
    json = JSON.pretty_generate providers
    f.write json
  end

end

