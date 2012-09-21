class IndividualProvider < Provider
  belongs_to :name, class_name: "IndividualName"
  accepts_nested_attributes_for :name
  attr_accessible :name, :name_attributes

  index_name Provider.index_name
  document_type :provider

end
