require 'spec_helper.rb'

describe Name do
  describe 'construction' do
    it do
      should have_initializable_attributes(
        :last, :first, :middle, :credentials,
        :prefix, :suffix, :legal_business_name)
    end
  end
end
