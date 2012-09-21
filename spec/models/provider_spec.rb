require 'spec_helper'

describe Provider do
  it { should have_many :specialties }
  it { should have_one(:mailing_address).class_name("Address") }
  it { should have_one(:practice_address).class_name("Address") }
  it { should belong_to(:parent_provider).class_name("Provider") }
end
