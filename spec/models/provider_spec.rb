require 'spec_helper'

describe Provider do
  it { should have_and_belong_to_many :specialties }
end
