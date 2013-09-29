FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end
end

FactoryGirl.define do

  factory :property do
    name FactoryGirl.generate :name
    data_type
    collection
  end

  factory :collection do
    name FactoryGirl.generate :name
    factory :collection_with_properties do

      ignore do
        properties_count 1
      end

      after(:build) do |collection, evaluator|
        FactoryGirl.create_list(:property, evaluator.properties_count, collection: collection)
      end
    end
  end

end
