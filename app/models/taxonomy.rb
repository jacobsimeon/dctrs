class Taxonomy < ActiveRecord::Base
  attr_accessible :code, :description, :name
  belongs_to :category, :class_name => "TaxonomyCategory"
  belongs_to :parent_taxonomy, :class_name => "Taxonomy"
end
