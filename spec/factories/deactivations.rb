# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deactivation do
    deactivated_on "2012-09-20"
    reactivated_on "2012-09-20"
    reason "MyString"
  end
end
