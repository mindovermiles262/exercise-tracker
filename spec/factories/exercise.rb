FactoryGirl.define do
  factory :exercise do
    association :user, factory: :user
    exercise_time Time.current
  end
end