FactoryBot.define do
  factory :user do
     sequence(:name) { |n| "Tester#{n}"}
     sequence(:email) { |n| "tester#{n}@example.com" }
     password { "dottle-nouveau-pavilion-tights-furze"}
     trait :admin do
       admin {true}
     end
  end

end
