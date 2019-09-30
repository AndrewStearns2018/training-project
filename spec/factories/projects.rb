FactoryBot.define do
  factory :project do
    name { "Tuileries" }
    short_description { "Rebuild the Tuileries" }
    long_description { "Let's get a shit-ton of money and rebuild the Tuileries." }
    goal { 1000 }
    # landscape_image { "MyString" }
    # thumbnail_image { "MyString" }
    association :category, name: "Business"
  end
end
