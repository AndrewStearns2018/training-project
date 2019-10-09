require 'mangopay'


# configuration
MangoPay.configure do |c|
  c.preproduction = true
  c.client_id = ENV["mango_pay_client_id"]
  c.client_apiKey = ENV["mango_pay_api_key"]
  c.http_timeout = 10000
end


# get some user by id
# john = MangoPay::User.fetch(john_id) # => {FirstName"=>"John", "LastName"=>"Doe", ...}


# # update some of his data
# MangoPay::NaturalUser.update(john_id, {'LastName' => 'CHANGED'}) # => {FirstName"=>"John", "LastName"=>"CHANGED", ...}


# # get all users (with pagination)
# pagination = {'page' => 1, 'per_page' => 8} # get 1st page, 8 items per page
# users = MangoPay::User.fetch(pagination) # => [{...}, ...]: list of 8 users data hashes
# pagination # => {"page"=>1, "per_page"=>8, "total_pages"=>748, "total_items"=>5978}

# # pass custom filters (transactions reporting filters)
# filters = {'MinFeesAmount' => 1, 'MinFeesCurrency' => 'EUR', 'MaxFeesAmount' => 1000, 'MaxFeesCurrency' => 'EUR'}
# reports = MangoPay::Report.fetch(filters) # => [{...}, ...]: list of transaction reports between 1 and 1000 EUR

# # get John's bank accounts
# accounts = MangoPay::BankAccount.fetch(john_id) # => [{...}, ...]: list of accounts data hashes (10 per page by default)


# # error handling
# begin
#   MangoPay::NaturalUser.create({})
# rescue MangoPay::ResponseError => ex

#   ex # => #<MangoPay::ResponseError: One or several required parameters are missing or incorrect. [...] FirstName: The FirstName field is required. LastName: The LastName field is required. Nationality: The Nationality field is required.>

#   ex.details # => {
#              #   "Message"=>"One or several required parameters are missing or incorrect. [...]",
#              #   "Type"=>"param_error",
#              #   "Id"=>"5c080105-4da3-467d-820d-0906164e55fe",
#              #   "Date"=>1409048671.0,
#              #   "errors"=>{
#              #     "FirstName"=>"The FirstName field is required.",
#              #     "LastName"=>"The LastName field is required.", ...},
#              #   "Code"=>"400",
#              #   "Url"=>"/v2/.../users/natural"
#              # }
# end
