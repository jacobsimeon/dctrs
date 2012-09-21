# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identifier do
    provider nil
    identifier_type "MyString"
    state "MyString"
    issuer "MyString"
  end
end
