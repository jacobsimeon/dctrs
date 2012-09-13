require 'spec_helper'

describe IndividualProvider do
  it { should accept_nested_attributes_for(:name) }
  it { should have_one :name }
end
