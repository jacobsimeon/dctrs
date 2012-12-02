require 'spec_helper.rb'

describe AuthorizedOfficial do
  describe 'construction' do
    it do
      should have_initializable_attributes(:title, :phone)
    end

    context 'with nested name attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :name }
        let(:child_property_class) { Name }
      end
    end

  end
end
