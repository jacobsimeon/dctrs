task :import => :environment do
  require 'csv'

  def transform_row row 
    # some column names are too long for PG
    row.inject do |new_row, (key, value)|
      new_row[(key.gsub('business_practice_location_address', 'bpla').to_sym rescue key)] = value
      new_row
    end
  end

  count = 0
  options = { headers: true, header_converters: :symbol }
  providers_file = '/Volumes/Data/Users/jacobsimeon/Projects/jacobsimeon/providers/npidata_20050523-20120709.csv'

  puts "Reading CSV file #{providers_file}"
  CSV.foreach(providers_file, options) do |row|
    puts "Starting import" if count == 0
    RawProvider.create_or_update transform_row(row.to_hash)
    count += 1
    puts "Imported #{count} providers" if count % 1000 == 0
  end

end

