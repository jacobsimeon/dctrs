require 'spec_helper'

describe Provider do
  it { should have_many :specialties }
  it { should have_one :mailing_address }
  it { should have_one :practice_address }
end
