require 'spec_helper.rb'

describe Address do
  describe 'construction' do
    it do
      should have_initializable_attributes(
        :first_line,
        :city,
        :state,
        :zip,
        :phone,
        :fax
      )
    end
  end
end
