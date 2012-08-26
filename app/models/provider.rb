class Provider < ActiveRecord::Base
  attr_accessible :name
  has_one :name
end
