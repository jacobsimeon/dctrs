class OrgName < ActiveRecord::Base
  attr_accessible :legal_business_name
  belongs_to :organization_provider

  def to_s
    legal_business_name
  end
end
