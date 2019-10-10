FactoryBot.define do
  factory :contribution do
    association :user, email: 'new_test@example.com'
    amount { 1000.0 }
    association :project, strategy: :build
    association :reward, strategy: :build
  end
end
