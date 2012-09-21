require 'spec_helper'

describe ProviderOrganization do
  it { should belong_to(:name).class_name("OrgName") }
  it { should accept_nested_attributes_for :name }
end
