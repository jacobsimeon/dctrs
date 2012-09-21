# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :license do
    provider nil
    number "MyString"
    state "MyString"
  end
end
