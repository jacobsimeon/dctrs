require 'spec_helper.rb'

describe Provider do
  describe 'construction' do
    it { should have_initializable_attributes(:npi, :entity_type) }

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

    context 'with nested authorized official attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :authorized_official }
        let(:child_property_class) { AuthorizedOfficial }
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

  describe 'saving and retrieving' do
    before :each do
      Provider.index.delete
      Provider.index.create
    end

    it 'can search by npi' do
      provider_attrs = JSON.parse(File.read('spec/support/providers.json'))
      provider = Provider.new provider_attrs[0]
      provider.save
      Provider.index.refresh
      retrieved_provider = Provider.search provider.npi
      retrieved_provider[0].id.should == provider.id
    end
  end

  describe 'primary_specialty' do
    it 'finds the first specialty with :is_primary set to true' do
      the_primary_specialty = Specialty.new
      not_primary = Specialty.new
      provider = Provider.new
      provider.specialties = [not_primary, the_primary_specialty]
      provider.primary_specialty.should be(the_primary_specialty)
    end

  end
end

