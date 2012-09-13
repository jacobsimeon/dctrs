require 'spec_helper'

describe TaxonomyCategory do
  it { should have_many :taxonomies }
end
