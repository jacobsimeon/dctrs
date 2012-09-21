class License < ActiveRecord::Base
  belongs_to :provider
  attr_accessible :number, :state
end
