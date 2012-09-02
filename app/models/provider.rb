class Provider < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_one :name
  accepts_nested_attributes_for :name
  attr_accessible :name, :name_attributes

  index_name "#{Tire::Model::Search.index_prefix}providers"
  after_touch { tire.update_index }

  def self.provider_index_settings
    {
      :settings => {
        "analysis" => {
          "analyzer" => {
            "provider_analyzer" => {
              "tokenizer"    => "lowercase",
              "filter"       => ["provider_ngram"],
              "type"         => "custom"
            }
          },
          "filter" => {
            "provider_ngram"  => {
              "type"     => "edgeNGram",
              "min_gram" => 2,
              "max_gram" => 50,
              "side" => "front"
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

  def to_indexed_json
    { id: id, name: { first: (name.first rescue ""), last: (name.last rescue "")}}.to_json
  end

end
