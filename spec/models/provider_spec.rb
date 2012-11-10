require 'spec_helper.rb'

describe Provider do
  describe 'construction' do
    it 'accepts npi property' do
      provider = Provider.new npi: "Some NPI Number"
      provider.npi.should == "Some NPI Number"
    end

    it 'accepts entity_type property' do
      provider = Provider.new entity_type: :organization
      provider.entity_type.should == :organization
    end

    context 'with nested name attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :name }
        let(:child_property_class) { Name }
      end
    end

    context 'with nested mailing_address attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :mailing_address }
        let(:child_property_class) { Address }
      end
    end

    context 'with nested practice location attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :practice_location }
        let(:child_property_class) { Address }
      end
    end

    context 'with nested specialties attributes' do
      it_behaves_like 'a nested collection' do
        let(:child_collection_name) { :specialties }
        let(:child_collection_class) { Specialty }
      end
    end

    context 'with nested identifiers attributes' do
      it_behaves_like 'a nested collection' do
        let(:child_collection_name) { :identifiers }
        let(:child_collection_class) { Identifier }
      end
    end

  end
end

