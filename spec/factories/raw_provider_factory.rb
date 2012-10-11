require 'nppes/raw_provider'
require 'date'

FactoryGirl.define do
  factory :raw_provider, :class => Nppes::RawProvider do

    npi "1679576722"

    factory :raw_individual do
      entity_type_code "1"
      provider_last_name_legal_name "PILCHER"
      provider_first_name "JACOB"
      provider_middle_name "ShAwN"
      provider_credential_text "M.D."
      provider_name_prefix_text "Mr."
      provider_name_suffix_text "Jr."
    end

    factory :raw_org do
      entity_type_code "2"
      provider_organization_name_legal_business_name "SOME ORGANIZATION NAME"
    end

    factory :provider_with_mailing_address do
      provider_first_line_business_mailing_address "PO BOX 2168"
      provider_business_mailing_address_city_name "KEARNEY"
      provider_business_mailing_address_state_name "NE"
      provider_business_mailing_address_postal_code "688482168"
      provider_business_mailing_address_country_code_if_outside_us "US"
      provider_business_mailing_address_telephone_number "3088652512"
      provider_business_mailing_address_fax_number "3088652506"
    end

    factory :provider_with_practice_location do
      provider_first_line_business_practice_location_address "PO BOX 2168"
      provider_business_practice_location_address_city_name "KEARNEY"
      provider_business_practice_location_address_state_name "NE"
      provider_business_practice_location_address_postal_code "688482168"
      provider_business_practice_location_address_country_code_if_outside_us "US"
      provider_business_practice_location_address_telephone_number "3088652512"
      provider_business_practice_location_address_fax_number "3088652506"
    end

    factory :provider_with_deactivation do
      npi_deactivation_reason_code "DT"
      npi_deactivation_date "05/23/2005"
      npi_reactivation_date "05/23/2006"
    end

    factory :provider_with_no_deactivation do
      npi_deactivation_reason_code ""
      npi_deactivation_date ""
      npi_reactivation_date ""
    end

    factory :provider_with_authorized_official do
      authorized_official_last_name "Jones"
      authorized_official_first_name "Audrey"
      authorized_official_middle_name "Reed"
      authorized_official_title_or_position "Supreme Pontiff"
      authorized_official_telephone_number "(321) 555-5555"
      authorized_official_name_prefix_text "Mrs."
      authorized_official_name_suffix_text "III"
      authorized_official_credential_text "M.D."
    end

    factory :provider_with_no_authorized_official do
      authorized_official_last_name ""
    end

    factory :provider_with_some_taxonomies do
      healthcare_provider_taxonomy_code_1 "207X00000X"
      provider_license_number_1 "12637"
      provider_license_number_state_code_1 "NE"
      healthcare_provider_primary_taxonomy_switch_1 "Y"

      healthcare_provider_taxonomy_code_2 "208X00000X"
      provider_license_number_2 "22637"
      provider_license_number_state_code_2 "NE"
      healthcare_provider_primary_taxonomy_switch_2 "N"
    end

    factory :provider_with_identifiers do
      other_provider_identifier_1 "645540"
      other_provider_identifier_type_code_1 "1"
      other_provider_identifier_state_1 "KS"
      other_provider_identifier_issuer_1 "FIRSTGUARD"

      other_provider_identifier_2 "1553"
      other_provider_identifier_type_code_2 "1"
      other_provider_identifier_state_2 "NE"
      other_provider_identifier_issuer_2 "BCBS"

      other_provider_identifier_3 "93420WI"
      other_provider_identifier_type_code_3 "4"
      other_provider_identifier_state_3 "NE"

      other_provider_identifier_4 "46969"
      other_provider_identifier_type_code_4 "1"
      other_provider_identifier_state_4 "KS"
      other_provider_identifier_issuer_4 "BCBS"

      other_provider_identifier_5 "B67599"
      other_provider_identifier_type_code_5 "2"

      other_provider_identifier_6 "046969WI"
      other_provider_identifier_type_code_6 "4"
      other_provider_identifier_state_6 "KS"
    end

  end
end
