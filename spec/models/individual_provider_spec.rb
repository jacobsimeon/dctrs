require 'spec_helper'
describe IndividualProvider do
  it { should have_one(:name) }
  it { should have_one(:other_name).class_name(:Name) }
end
