FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "これは#{n}番目の投稿です" }
    association :user
  end
end
