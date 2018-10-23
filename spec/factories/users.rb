FactoryBot.define do
  factory :user do
    email { 'bob@example.com' }
    password { '123456' }
    password_confirmation { password }
  end
end
