class Provider < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :name
  has_one :name

  index_name "#{Tire::Model::Search.index_prefix}providers"

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
      :mappings => {
        :provider => {
          "_all" => { "enabled" => true, :analyzer => :provider_analyzer },
          :properties => {
              :id => { :type => :integer },
              :full_name => {
                :type => :string,
                :analyzer => :provider_analyzer,
                :include_in_all => true
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

  def self.search(params)
    tire.search do
      query { string params["query"] }
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
