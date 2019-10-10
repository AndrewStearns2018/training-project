FactoryBot.define do
  factory :reward do
    name { "Dedication" }
    description { "We will name a stone after you." }
    units { 100 }
    price { 50 }
    association :project, strategy: :build
  end
end
