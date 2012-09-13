class TaxonomyCategory < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :taxonomies, :as => :category
end
