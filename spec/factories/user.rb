FactoryGirl.define do
  factory :user do
    name "Example User"
    email "rspec@example.com"
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end
end