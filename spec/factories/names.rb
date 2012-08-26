# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :name do
    factory :last, :aliases => [:seuss_name] do
      first "Dr."
      last "Seuss"
    end
    factory :first, :aliases => [:jacob_name] do
      first "Jacob"
      last "Morris"
    end
  end
end
