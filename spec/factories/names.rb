# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :individual_name do
    first "John"
    last "Doe"

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
