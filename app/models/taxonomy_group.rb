class TaxonomyGroup < ActiveRecord::Base
  belongs_to :provider
  attr_accessible :group
end
