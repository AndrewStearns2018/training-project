require "dry/transaction"

class CreateUserTransaction
  include Dry::Transaction

  tee :params
  step :create
  step :create_mango_user
  step :create_user_wallet
  step :send_welcome_email

  private

  def params(input)
    @user = input[:user]
  end

  def create(_input)
    if @user.save
      Success(@user)
    else
      Failure(error: @user.errors.full_messages)
    end
  end

  def create_mango_user(_input)
    mango_user = MangoPay::NaturalUser.create({
      "FirstName": @user.first_name,
      "LastName": @user.last_name,
      "Birthday": @user.date_of_birth.to_time.to_i,
      "Nationality": @user.nationality,
      "CountryOfResidence": @user.country_of_residence,
      "Email": @user.email
    })

    if mango_user["Id"]
      @user.update(mango_user_id: mango_user["Id"])
      Success(@user)
    else
      Failure(@user)
    end
  end

  def create_user_wallet(_input)
    wallet = MangoPay::Wallet.create({
      "Owners": [ @user.mango_user_id ],
      "Description": @user.last_name,
      "Currency": "EUR"
    })

    if wallet["Id"]
      @user.update(mango_wallet_id: wallet["Id"])
      Success(@user)
    else
      Failure(@user)
    end
  end

  def send_welcome_email(_input)
    UserMailer.welcome(@user.id).deliver_now
      Success(@user)
    rescue StandardError => exception
      Failure(error: exception)
  end
end
