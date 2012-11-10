require 'nppes/raw_taxonomy'

FactoryGirl.define do
  factory :raw_specialty, :class => Nppes::RawTaxonomy do
    code '101Y00000X'
    type 'Behavioral Health & Social Service Providers'
    classification 'Counselor'
    specialization 'Addiction'
    definition 'The Definition'
    notes 'some notes'
  end
end
