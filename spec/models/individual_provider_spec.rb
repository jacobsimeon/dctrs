require 'spec_helper'

describe IndividualProvider do
  it { should accept_nested_attributes_for(:name) }
  it { should have_one :name }
  describe '#to_indexed_json' do

    it 'returns a string' do
      @p = create :individual_provider
      @p.to_indexed_json.should be_a(String)
    end

    it 'uses empty specialty when provider has no specialties' do
      @p = create :individual_provider
      JSON.parse(@p.to_indexed_json)["specialty"].should == {
        "name" => nil,
        "description" => nil
      }
    end

    it 'serializes the providers specialty' do
      @p = create :individual_provider
      @p.specialties.push(create :ortho)
      json = JSON.parse(@p.to_indexed_json)
      json["specialty"]["name"].should == "Orthopaedic Surgery"
    end

  end
end
