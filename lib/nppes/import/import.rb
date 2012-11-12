require 'csv'
require 'json'
require './lib/nppes/raw_provider'
require 'tire'
require './lib/initializable'
require './app/models/address'
require './app/models/authorized_official'
require './app/models/identifier'
require './app/models/license'
require './app/models/name'
require './app/models/specialty'
require './app/models/provider'

module Nppes
  SPECIALTIES_FILE_PATH = './lib/nppes/data/specialties.json'
  class Import
    attr_accessor :specialties
    attr_accessor :import_file_path

    def initialize import_path, csv=CSV
      @csv = csv
      initialize_specialties
      self.import_file_path = import_path
    end

    def initialize_specialties
      if File.exists? SPECIALTIES_FILE_PATH
        @specialties = JSON.parse(File.read(SPECIALTIES_FILE_PATH))
      else
        raise "#{SPECIALTIES_FILE_PATH} does not exist"
      end
    end

    def import_file_path=(path)
      if File.exists? path
        @import_file_path = path
      else
        raise "#{path} does not exist"
      end
    end

    def import_providers
      @csv.foreach(import_file_path, :headers => true, :header_converters => :symbol) do |row|
        Provider.new(RawProvider.new(row.to_hash).to_hash).save
      end
    end
  end
end
