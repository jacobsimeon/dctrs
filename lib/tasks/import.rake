
ENV['ELASTICSEARCH_URL'] = 'http://xq0vkvx0:ido6siqdctum40h5@holly-4358549.us-east-1.bonsai.io'

require 'monitor'
require 'csv'
require 'json'
require 'tire'

require './lib/nppes/raw_provider.rb'
require './lib/initializable'
require './app/models/address'
require './app/models/authorized_official'
require './app/models/identifier'
require './app/models/license'
require './app/models/name'
require './app/models/specialty'
require './app/models/provider'
require 'time'

class ImportLogger
  def initialize(file)
    @log_file ||= File.open file, 'w+'
    self.extend MonitorMixin
  end

  def log statement
    self.synchronize do
      statement = "[#{Thread.current.object_id}][#{Time.now.to_s}]#{statement}"
      @log_file.puts statement
      @log_file.flush
    end
  end
end

class ProviderImporter

  def initialize
    @taxonomies = JSON.parse(File.read('./lib/data/specialties.json'))
  end

  def run_imports
    recreate_index
    process_providers
  end

  def recreate_index
    Provider.index.delete
    Provider.index.create
  end

  def process_providers
    pids = get_import_file_list.each_slice(10).map do |file_group|
      process_file_group file_group
    end
    pids.each { |pid| Process.wait pid }
  end

  def get_import_file_list
    Dir.foreach('../providers/files').map do |file_name|
      next if file_name == '.' or file_name == '..'
      file_name
    end.delete_if { |f| f.nil? }
  end

  def process_file_group file_group
    fork do
      @logger = ImportLogger.new "./log/#{file_group.first}.log"
      threads = file_group.map do |file|
        process_file file
      end
      threads.each { |t| t.join }
    end
  end

  def process_file file
    Thread.start do
      options = { headers: true, header_converters: :symbol }
      file = '../providers/files/' + file
      count = 0
      CSV.foreach(file, options) do |row|
        begin
          build_provider_from_row row
        rescue StandardError => e
          @logger.log e
        end
        count += 1
        if count % 100 == 0
          @logger.log "Logged #{count} providers"
        end
      end
    end
  end

  def build_provider_from_row row
    raw_provider = Nppes::RawProvider.new row.to_hash, @taxonomies
    provider = Provider.new raw_provider.to_hash
    provider.save
  end

end

#start a process for each 10 files in the import file directory
#each process starts a thread to process each file
task :new_import => :environment do
  ProviderImporter.new.run_imports
end

def simplify_to_ascii
  row.to_hash.keys.inject({}) do |hash, key|
    hash[key] = row[key].to_s.force_encoding('UTF-8')
    hash
  end
end

namespace :taxonomies do
  task :to_json do
    path = './lib/data/taxonomies.csv'

    specialties = CSV.table(path).inject({}) do |taxonomies, row|
      taxonomies[row[:code]] = simplify_to_ascii row
      taxonomies
    end

    specialties = JSON.pretty_generate(specialties)
    File.open('tmp/specialties.json', 'w+') do |f|
      f.puts specialties.force_encoding('UTF-8')
    end
  end
end
=end
