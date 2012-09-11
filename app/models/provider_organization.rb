class ProviderOrganization < Provider
  has_one :name, class_name: :OrgName
  accepts_nested_attributes_for :name
  attr_accessible :name, :name_attributes

  index_name Provider.index_name
  document_type :provider

  def to_indexed_json
    { "id" => id,
      "name" => {
        "legal_business_name" => name.legal_business_name
      }
    }.to_json
  end
end
