class Specialty < ActiveRecord::Base
  attr_accessible :code, :description, :name
  has_and_belongs_to_many :providers
end
