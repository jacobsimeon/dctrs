require 'spec_helper.rb'

describe Identifier do
  describe 'construction' do
    it do
      should have_initializable_attributes(:value, :type, :state, :issuer)
    end
  end
end
