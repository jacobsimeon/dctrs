require 'spec_helper'

describe Specialty do
  it { should have_and_belong_to_many :providers }
end
