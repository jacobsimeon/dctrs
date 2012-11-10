require 'spec_helper.rb'

describe Specialty do
  describe 'construction' do
    it do
      should have_initializable_attributes(
        :code,
        :is_primary,
        :type,
        :classification,
        :specialization,
        :definition,
        :notes)
    end

    context 'with nested license attributes' do
      it_behaves_like 'a nested property' do
        let(:property_name) { :license }
        let(:child_property_class) { License }
      end
    end

  end
end
