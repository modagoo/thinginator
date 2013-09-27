FactoryGirl.define do

  factory :thing do
    association :collection, factory: :collection_with_property
    make "Kona"

    factory :thing_with_property do
      ignore do
        properties_count 5
      end

      after(:create) do |thing, evaluator|
        FactoryGirl.create_list(:property, evaluator.properties_count, thing: thing)
      end
    end
  end

end
