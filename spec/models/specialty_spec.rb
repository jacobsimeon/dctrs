require 'spec_helper'

describe Specialty do
  it { should belong_to :provider }
  it { should belong_to :taxonomy }
end
