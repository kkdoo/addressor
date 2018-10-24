FactoryBot.define do
  factory :user do
    email { 'bob@example.com' }
    password { '123456' }
    password_confirmation { password }

    trait :with_address do
      address { 'a'*34 }
    end
  end
end
