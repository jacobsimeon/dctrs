require 'lib/helper.rb'

module Nppes
  describe RawProvider do
    describe '#to_hash' do
      def transform data
        @raw = data.is_a?(Hash) ? data : attributes_for(data)
        @taxonomies = JSON.parse(File.read('./tmp/specialties.json'))
        @provider = RawProvider.new(@raw, @taxonomies).to_hash
      end

      before { transform :raw_provider }
      subject { @provider }

      it { should be_a Hash }

      it 'sets the npi' do
        @provider[:npi].should == @raw[:npi]
      end

      context 'when the entity type is 2 (organization)' do
        before { transform :raw_org }

        it 'sets the entity type to organization' do
          @provider[:entity_type].should == :organization
        end

        it 'sets the legal business name' do
          @provider[:name][:legal_business_name].should ==
            @raw[:provider_organization_name_legal_business_name].capitalize
        end
      end

      context 'when the entity type is 1 (individual)' do
        before  do
          transform :raw_individual
          @name = @provider[:name]
        end

        it 'sets the entity type to individual' do
          @provider[:entity_type].should == :individual
        end

        it 'sets the last name' do
          @name[:last].should == @raw[:provider_last_name_legal_name].capitalize
        end

        it 'sets the first name' do
          @name[:first].should == @raw[:provider_first_name].capitalize
        end

        it 'sets the middle name' do
          @name[:middle].should == @raw[:provider_middle_name].capitalize
        end

        it 'sets the credentials' do
          @name[:credentials].should == @raw[:provider_credential_text]
        end

        it 'sets the prefix' do
          @name[:prefix].should == "Mr."
        end

        it 'sets the suffix' do
          @name[:suffix].should == "Jr."
        end
      end

      context 'when there is a mailing address' do
        def mailing_address key
          @raw[key = ("provider_business_mailing_address_" + key.to_s).to_sym]
        end

        before do
          transform :provider_with_mailing_address
          @address = @provider[:mailing_address]
        end

        it 'sets the first line' do
          @address[:first_line].should ==
            @raw[:provider_first_line_business_mailing_address]
        end

        it 'sets the city' do
          @address[:city].should == mailing_address(:city_name).capitalize
        end

        it 'sets the state' do
          @address[:state].should == mailing_address(:state_name)
        end

        it 'sets the postal code' do
          @address[:zip].should == mailing_address(:postal_code)
        end

        it 'sets the phone number' do
          @address[:phone].should == mailing_address(:telephone_number)
        end

        it 'sets the fax number' do
          @address[:fax].should == mailing_address(:fax_number)
        end
      end

      context 'when there is a business practice location address' do
        def location_address key
          @raw[key = ("provider_business_practice_location_address_" + key.to_s).to_sym]
        end

        before do
          transform :provider_with_practice_location
          @address = @provider[:practice_location]
        end

        it 'sets the first line' do
          @address[:first_line].should ==
            @raw[:provider_first_line_business_practice_location_address]
        end

        it 'sets the city' do
          @address[:city].should == location_address(:city_name).capitalize
        end

        it 'sets the state' do
          @address[:state].should == location_address(:state_name)
        end

        it 'sets the postal code' do
          @address[:zip].should == location_address(:postal_code)
        end

        it 'sets the phone number' do
          @address[:phone].should == location_address(:telephone_number)
        end

        it 'sets the fax number' do
          @address[:fax].should == location_address(:fax_number)
        end
      end

      context 'when there is a deactivation' do
        before do
          transform :provider_with_deactivation
          @deactivation = @provider[:deactivation]
        end

        it 'sets the deactivation code' do
         @deactivation[:reason].should == "DT"
        end

        it 'sets the the deactivation date' do
          @deactivation[:deactivated_on].should == "05/23/2005"
        end

        it 'sets the re-activation date' do
          @deactivation[:reactivated_on].should == "05/23/2006"
        end
      end

      context 'when there is no deactivation code' do
        before do
          transform :provider_with_no_deactivation
          @deactivation = @provider[:deactivation]
        end
        subject { @deactivation }
        it { should be_nil }
        it 'should not have deactivation key' do
          @provider.should_not have_key :deactivation
        end
      end

      context 'when there is an authorized official' do
        before do
          transform :provider_with_authorized_official
          @official = @provider[:authorized_official]
        end

        it 'sets their title' do
          @official[:title].should == "Supreme Pontiff"
        end

        it 'sets their phone' do
          @official[:phone].should == "(321) 555-5555"
        end

        it 'sets their last name' do
          @official[:name][:last].should == "Jones"
        end

        it 'sets their first name' do
          @official[:name][:first].should == "Audrey"
        end

        it 'sets their middle name' do
          @official[:name][:middle].should == "Reed"
        end

        it 'sets their prefix' do
          @official[:name][:prefix].should == "Mrs."
        end

        it 'sets their suffix' do
          @official[:name][:suffix].should == "III"
        end

        it 'sets their credential' do
          @official[:name][:credentials].should == "M.D."
        end
      end

      context 'when there is no authorized official' do
        before do
          transform :provider_with_no_authorized_official
        end
        subject { @provider }
        it { should_not have_key :authorized_official }
      end

      describe 'the specialties key' do
        before do
          transform :provider_with_some_taxonomies
          @specialties = @provider[:specialties]
        end

        it 'creates the correct number of specialties' do
          @specialties.count.should be(2)
        end

        it 'sets the right taxonomy code' do
          @specialties[0][:code].should == "207X00000X"
        end

        it 'sets the classification' do
          @specialties[0][:classification].should == 'Orthopaedic Surgery'
        end

        context 'when the primary switch is "Y"' do
          it 'sets :is_primary to true' do
            @specialties[0][:is_primary].should be_true
          end
        end

        context 'when the primary switch is "N"' do
          it 'sets :is_primary to false' do
            @specialties[1][:is_primary].should be_false
          end
        end

        it 'builds a license with a number' do
          @specialties[0][:license][:number].should == "12637"
        end

        it 'builds a license with state code' do
          @specialties[0][:license][:state].should == "NE"
        end
      end

      describe 'the identifiers key' do
        before do
          transform :provider_with_identifiers
          @identifiers = @provider[:identifiers]
        end

        it 'creates the correct number of identifiers' do
          @identifiers.count.should be(6)
        end

        it 'sets the identifier value' do
          @identifiers[0][:value].should == "645540"
        end

        it 'sets the the type code' do
          @identifiers[0][:type].should == "1"
        end

        context 'there is no state' do
          it 'does nothing with the state' do
            @identifiers[4].should_not have_key(:state)
          end
        end

        context 'there is a state' do
          it 'sets the state' do
            @identifiers[0][:state].should == "KS"
          end
        end

        context 'there is an issuer' do
          it 'sets the issuer' do
            @identifiers[0][:issuer].should == "FIRSTGUARD"
          end
        end

        context 'there is no issuer' do
          it 'does not create an :issuer key' do
            @identifiers[2].should_not have_key(:issuer)
          end
        end
      end
    end
  end
end
