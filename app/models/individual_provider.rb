class IndividualProvider < Provider
  has_one :name, class_name: :IndividualName
  accepts_nested_attributes_for :name
  attr_accessible :name, :name_attributes

  index_name Provider.index_name
  document_type :provider

  def to_indexed_json
    { id: id, name: { first: (name.first rescue ""), last: (name.last rescue "")}}.to_json
  end
end