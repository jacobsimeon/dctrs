task :import do

  require 'csv'
  require 'json'
  require './lib/nppes/raw_provider.rb'

  puts "Starting..."
  taxonomies = JSON.parse(File.read('tmp/specialties.json'))

  providers = []
  CSV.foreach("tmp/mini_providers.csv", :headers => true, :header_converters => :symbol) do |row|
    "Parsing provider"
    providers.push Nppes::RawProvider.new(row.to_hash, taxonomies).to_hash
  end

  File.open('tmp/mini_provider.json', 'w+') do |f|
    json = JSON.pretty_generate providers
    f.write json
  end

end

namespace :taxonomies do
  task :to_json do
    require 'csv'
    require 'json'
    require 'pp'

    specialties = CSV.table('tmp/taxonomies.csv').inject({}) do |taxonomies, row|
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

