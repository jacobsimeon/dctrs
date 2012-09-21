class AuthorizedOfficial < ActiveRecord::Base
  belongs_to :name, class_name: "IndividualName"
  attr_accessible :phone, :title, :name_attributes
  accepts_nested_attributes_for :name
end
