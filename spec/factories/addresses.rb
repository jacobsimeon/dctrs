# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    first_line "MyString"
    second_line "MyString"
    city "MyString"
     ""
    zip "MyString"
    phone "MyString"
    fax "MyString"
  end
end
