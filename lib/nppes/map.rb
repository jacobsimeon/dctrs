require 'rubygems'
require 'fastercsv'
require 'json'
require 'net/http'

class PrefixedHashWrapper
  def initialize(prefix, unprefixed, capitalize=false)
    @prefix = prefix.to_s
    @unprefixed = unprefixed
    @capitalize = capitalize
  end
  def [](key)
    val = (@unprefixed[(@prefix + key.to_s).to_sym] || "")
    @capitalize ? val.capitalize : val
  end
end

class Hash
  def with_prefix(prefix, suffix=nil)
    wrapper = PrefixedHashWrapper.new(prefix, self)
    capitalizer = PrefixedHashWrapper.new(prefix, self, :capitalize)
    yield(wrapper, capitalizer)
  end
  def symbolize_keys
    self.keys.inject({}) do |hash, key|
      hash[key.to_sym] = self[key]
      hash
    end
  end
end

module Nppes
  class RawProvider

    def initialize data, taxonomies={}
      @raw = data
      @taxonomies = taxonomies
    end

    def to_hash
      return {} unless @raw
      attributes = {
        :npi => npi,
        :entity_type => entity_type,
        :name =>  name,
        :mailing_address =>  address(:mailing),
        :practice_location =>  address(:practice_location),
        :deactivation =>  deactivation,
        :authorized_official =>  authorized_official,
        :specialties =>  specialties,
        :identifiers =>  identifiers
      }
      attributes.delete_if { |_, value| value.nil? }
      attributes
    end

    private
    def npi
      @raw[:npi]
    end

    def entity_type
      @raw[:entity_type_code] == "1" ? :individual : :organization
    end

    def name
      send("#{entity_type}_name")
    end

    def organization_name
      @raw.with_prefix :provider_organization_name_ do |_, name|
        { :legal_business_name => name[:legal_business_name] }
      end
    end

    def individual_name
      @raw.with_prefix :provider_ do |name, capitalized|
        {
          :last =>  capitalized[:last_name_legal_name],
          :first =>  capitalized[:first_name],
          :middle =>  capitalized[:middle_name],
          :credentials =>  name[:credential_text],
          :prefix =>  name[:name_prefix_text],
          :suffix =>  name[:name_suffix_text]
        }
      end
    end

    def address type
      prefix = ("provider_business_%s_address_" % type.to_s).to_sym
      first_line = ("provider_first_line_business_%s_address" % type).to_sym
      @raw.with_prefix(prefix) do |addr, capitalized|
        {
          :first_line =>  @raw[first_line],
          :city =>  capitalized[:city_name],
          :state =>  addr[:state_name],
          :zip =>  addr[:postal_code],
          :phone =>  addr[:telephone_number],
          :fax =>  addr[:fax_number]
        }
      end
    end

    def deactivation
      reason = @raw[:npi_deactivation_reason_code]
      unless reason.nil? || reason.empty?
        {
          :reason =>  @raw[:npi_deactivation_reason_code],
          :deactivated_on =>  @raw[:npi_deactivation_date],
          :reactivated_on =>  @raw[:npi_reactivation_date]
        }
      end
    end

    def authorized_official
      ao_last_name = @raw[:authorized_official_last_name]
      return nil if ao_last_name.nil? || ao_last_name.empty?

      @raw.with_prefix(:authorized_official_) do |ao, _|
        {
          :title => ao[:title_or_position],
          :phone => ao[:telephone_number],
          :name => {
            :last => ao[:last_name],
            :first => ao[:first_name],
            :middle => ao[:middle_name],
            :prefix => ao[:name_prefix_text],
            :suffix => ao[:name_suffix_text],
            :credentials => ao[:credential_text]
          }
        }
      end
    end

    def specialties
      _specialties = []
      while specialty = get_specialty(_specialties.count + 1)
        _specialties.push specialty
      end
      _specialties
    end

    def get_specialty number
      if taxonomy_is_present number
        specialty = @raw.with_prefix(:healthcare_provider_) do |tax, _|
          specialty = {
            :code => tax["taxonomy_code_#{number}"],
            :is_primary => (tax["primary_taxonomy_switch_#{number}"] == "Y"),
            :license => get_license(number) }
            taxonomy = (@taxonomies[specialty[:code]] || {}).symbolize_keys
            specialty.merge taxonomy
        end
      end
    end

    def taxonomy_is_present number
      taxonomy = @raw["healthcare_provider_taxonomy_code_#{number}".to_sym]
      taxonomy_is_present = (!taxonomy.nil? && !taxonomy.empty?)
    end

    def get_license number
      @raw.with_prefix(:provider_license_number_) do |license, _|
        { :number =>  license[number.to_s],
          :state =>  license["state_code_#{number}"] }
      end
    end

    def identifiers
      ids = []
      while id = get_identifier(ids.count + 1)
        ids.push id
      end
      ids
    end

    def get_identifier the_next
      if identifier_is_present the_next
        @raw.with_prefix(:other_provider_identifier_) do |other_id, _|
          id = {
            :value =>  other_id[the_next],
            :type =>  other_id["type_code_#{the_next}"],
          }
          get the_next, :state, :in => other_id, :and_put_in => id
          get the_next, :issuer, :in => other_id, :and_put_in => id
        end
      end
    end

    def get(the_next, key, options)
      val = options[:in]["#{key}_#{the_next}"]
      options[:and_put_in][key] = val unless val.nil? || val.empty?
      options[:and_put_in]
    end

    def identifier_is_present number
      id = @raw["other_provider_identifier_#{number}".to_sym]
      !id.nil? && !id.empty?
    end

  end

  class Importer
    def initialize
      @headers = JSON.parse(Net::HTTP.get(URI('http://dctrs.io/headers')))
      @taxonomies = JSON.parse(Net::HTTP.get(URI('http://dctrs.io/taxonomies')))
    end

    def import row_string
      begin
        operation_meta_data = { :index => { :_index => :providers, :_type => :provider }}
        options = { :headers => @headers, :header_converters => :symbol }

        row = FasterCSV.parse_line(row_string, options)

        provider = get_provider_json(row)
        operation_meta_data[:index][:_id] = provider[:id]

        puts operation_meta_data.to_json
        puts provider.to_json
      rescue StandardError => e
        puts "Unable to parse line: #{row_string}"
      end
    end

    private
    def get_provider_json row
      provider = build_raw_provider_from_row(row)
    end

    def build_raw_provider_from_row row
      raw_provider = Nppes::RawProvider.new(row.to_hash, @taxonomies).to_hash
      raw_provider[:id] = raw_provider[:npi]
      raw_provider
    end
  end
end

@importer = Nppes::Importer.new
ARGF.each { |line| @importer.import line }
