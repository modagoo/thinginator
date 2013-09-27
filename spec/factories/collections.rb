
FactoryGirl.define do

  factory :collection do
    name "Bicycles"

    factory :collection_with_property do

      after(:create) do |c|
        c.property = Factory(:property)
      end
    end
  end

end
