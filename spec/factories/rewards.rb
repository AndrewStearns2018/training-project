FactoryBot.define do
  factory :reward do
    name { "Dedication" }
    description { "We will name a stone after you." }
    units { 1 }
    association :project, strategy: :build
  end
end
