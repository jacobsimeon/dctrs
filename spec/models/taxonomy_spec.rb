require 'spec_helper'

describe Taxonomy do
  it { should belong_to(:category).class_name("TaxonomyCategory") }
  it { should belong_to(:parent_taxonomy).class_name("Taxonomy") }
  it { should have_many(:sub_taxonomies).class_name("Taxonomy") }
end
