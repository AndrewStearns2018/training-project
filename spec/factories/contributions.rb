FactoryBot.define do
  factory :contribution do
    association :user, email: 'new_test@example.com'
    amount { 100 }
    association :project, strategy: :build
    association :reward, strategy: :build
  end

  factory :paid_contribution, class: Contribution do
    association :user, email: 'new_test@example.com'
    amount { 50 }
    association :project, strategy: :build
    association :reward, strategy: :build
    pay_in_id { '69660060' }
  end

  factory :unpaid_contribution, class: Contribution do
    association :user, email: 'new_test@example.com'
    amount { 50 }
    association :project, strategy: :build
    association :reward, strategy: :build
    pay_in_id { '69660022' }
  end
end



