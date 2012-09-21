class Provider < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :specialties
  has_one :mailing_address, class_name: "Address"
  has_one :practice_address, class_name: "Address"
  belongs_to :parent_provider, class_name: "Provider"
  has_one :deactivation
  has_many :licenses
  has_many :identifiers

  index_name "#{Tire::Model::Search.index_prefix}providers"
  after_touch { tire.update_index }

  def specialty
    specialties.first || Specialty.new(:name => "None", :description => "This provider has no specialty")
  end

  def self.provider_index_settings
    {
      :settings => {
        :analysis => {
          :analyzer => {
            :provider_analyzer => {
              :tokenizer    => :standard,
              :filter       => [:no_apostrophe, :standard, :lowercase, :asciifolding, :provider_ngram, :provider_name_synonym],
              :type         => :custom
            }
          },
          :filter => {
            :provider_ngram  => {
              :type     => :edgeNGram,
              :min_gram => 2,
              :max_gram => 50,
              :side => :front
            },
            :provider_name_synonym => {
              :type => :synonym,
              :synonyms_path => "synonyms/providers.txt"
            },
            :no_apostrophe => {
              :type => :pattern_replace,
              :pattern => "'",
              :replacement => ""
            }
          },
        }
      },
      mappings: {
        provider: {
          _all: { enabled: true, analyzer: :provider_analyzer },
          properties: {
            id: { type: :integer },
            name: {
              include_in_all: true,
              type: :object,
              properties: {
                first: {
                  type: :string,
                  include_in_all: true,
                  analyzer: :snowball
                },
                last: {
                  type: :string,
                  include_in_all: true,
                  analyzer: :snowball
                },
                legal_business_name: {
                  type: :string,
                  include_in_all: true,
                  analyzer: :snowball
                },
                specialty: {
                  type: :object,
                  include_in_all: true,
                  properties: {
                    name: {
                      include_in_all: true,
                      type: :string,
                      analyzer: :snowball
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  end

  def self.create_search_index
    Tire.index(Provider.index_name) do
      create(Provider.provider_index_settings)
    end
  end

  def self.refresh_index
    index.refresh
  end

  def self.recreate_index
    index.delete
    create_search_index
  end

end
