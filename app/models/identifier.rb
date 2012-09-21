class Identifier < ActiveRecord::Base
  belongs_to :provider
  attr_accessible :identifier_type, :issuer, :state
end
