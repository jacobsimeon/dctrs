# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    factory :seuss do
      association :name, :factory => :last
    end
    factory :jacob do
      association :name, :factory => :first
    end
  end
end
