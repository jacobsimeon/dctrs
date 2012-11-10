require 'spec_helper.rb'

describe License do
  describe 'construction' do
    it do
      should have_initializable_attributes(:number, :state)
    end
  end
end
