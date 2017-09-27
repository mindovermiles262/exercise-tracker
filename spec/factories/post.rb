FactoryGirl.define do
  factory :post do
    body { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end
