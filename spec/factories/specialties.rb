# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialty do
    factory :ortho do
      code "207X00000X"
      name "Orthopaedic Surgery"
      description ""
    end
  end
end
