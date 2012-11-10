require 'lib/helper.rb'

module Nppes
  describe RawTaxonomy do
    describe 'transforming from csv' do
      before do
        raw_attrs = attributes_for :raw_specialty
        @specialty = RawTaxonomy.new(raw_attrs).to_hash
      end

      it 'sets the specialty code' do
        @specialty[:code].should == '101Y00000X'
      end

      it 'sets the type' do
        @specialty[:type].should == 'Behavioral Health & Social Service Providers'
      end

      it 'sets the classification' do
        @specialty[:classification].should == 'Counselor'
      end

      it 'sets the specialization' do
        @specialty[:specialization].should == 'Addiction'
      end

      it 'sets the definition' do
        @specialty[:definition].should == 'The Definition'
      end

      it 'sets the notes' do
        @specialty[:notes].should == 'some notes'
      end
    end
  end
end

