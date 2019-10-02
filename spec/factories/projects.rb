uploader = PhotoUploader.new(:store)
file = File.new(Rails.root.join('app/assets/images/seed/test_image.jpg'))
uploaded_file = uploader.upload(file)


FactoryBot.define do
  factory :project do
    name { "Tuileries" }
    short_description { "Rebuild the Tuileries" }
    long_description { "Let's get a shit-ton of money and rebuild the Tuileries." }
    goal { 1000 }
    landscape_image_data { uploaded_file.to_json }
    thumbnail_image_data { uploaded_file.to_json }
    association :category, strategy: :build
  end
end
