FactoryBot.define do
  factory :user do
    first_name { 'Henri' }
    last_name { 'de Test' }
    date_of_birth { Date.new(2000, 9, 25) }
    password { '123456' }
    email { 'henri@example.com' }
  end
end
