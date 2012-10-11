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

  factory :individual_provider do
    association :name, :factory => :individual_name do
      first "jacob"
      last "morris"
    end
  end
end
