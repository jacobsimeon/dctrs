task import: :environment do
  Provider.index.delete
  Provider.index.create
  require 'csv'
  require 'json'
  require './lib/nppes/raw_provider.rb'

  puts "Starting..."
  taxonomies = JSON.parse(File.read('./lib/data/specialties.json'))

  CSV.foreach("./lib/data/mini_providers.csv", :headers => true, :header_converters => :symbol) do |row|
    puts "Parsing provider"
    provider = Provider.new(Nppes::RawProvider.new(row.to_hash, taxonomies).to_hash).save
    puts "Saved a new provider with npi #{provider.npi}"
  end

end

namespace :taxonomies do
  task :to_json do
    require 'csv'
    require 'json'
    require 'pp'

    specialties = CSV.table('./lib/data/taxonomies.csv').inject({}) do |taxonomies, row|
      #sanitize non-ascii characters
      taxonomies[row[:code]] = row.to_hash.keys.inject({}) do |hash, key|
        hash[key] = row[key].to_s.force_encoding('UTF-8')
        hash
      end

      taxonomies
    end

    specialties = JSON.pretty_generate(specialties)
    File.open('tmp/specialties.json', 'w+') do |f|
      f.puts specialties.force_encoding('UTF-8')
    end
  end
end

