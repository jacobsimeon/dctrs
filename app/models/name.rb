class Name < ActiveRecord::Base
  attr_accessible :first, :last
  belongs_to :provider
end
