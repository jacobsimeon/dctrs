require 'spec_helper'

describe ProviderOrganization do
  it { should have_one :name }
  it { should accept_nested_attributes_for :name }
end
