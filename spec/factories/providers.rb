# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    factory :seuss do
      full_name "Dr. Seuss"
      association :name, :factory => :last
    end
    factory :jacob do
      full_name "Jacob Morris"
      association :name, :factory => :first
    end
  end
end
