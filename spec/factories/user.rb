FactoryBot.define do
  factory :user do
    first_name { 'Henri' }
    last_name { 'de Test' }
    date_of_birth { Date.new(2000, 9, 25) }
    nationality { 'FR' }
    country_of_residence { 'FR' }
    password { '123456' }
    email { 'henri@example.com' }
  end

  factory :contributor, class: User do
    first_name { 'Mango' }
    last_name { 'Contributor' }
    date_of_birth { Date.new(2000, 9, 25) }
    nationality { 'FR' }
    country_of_residence { 'FR' }
    password { '123456' }
    email { 'mango12@example.com' }
    mango_user_id { '69739592' }
    mango_wallet_id { '69739593' }
  end

  factory :project_owner, class: User do
    first_name { 'Mango' }
    last_name { 'Product Owner' }
    date_of_birth { Date.new(2000, 9, 25) }
    nationality { 'FR' }
    country_of_residence { 'FR' }
    password { '123456' }
    email { 'mango11@example.com' }
    mango_user_id { '69739506' }
    mango_wallet_id { '69739507' }
  end
end
