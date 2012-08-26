# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    factory :seuss do
      name 'Seuss'
    end
    factory :jacob do
      name 'Jacob'
    end
  end
end
