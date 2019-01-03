FactoryBot.define do
  factory :user do
    email { "taras@gmail.com" }
    firstname { "Taras" }
    lastname { "Poroshenko" }
    password { "password123" }
    password_confirmation { "password123" }

    trait :login do
      email { "taras@gmail.com" }
      password { "password123" }
    end
  end
end
