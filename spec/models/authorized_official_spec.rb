require 'spec_helper'

describe AuthorizedOfficial do
  it { should belong_to(:name).class_name("IndividualName") }
  it { should accept_nested_attributes_for :name }
end
