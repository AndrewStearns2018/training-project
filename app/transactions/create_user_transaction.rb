require "dry/transaction"

class CreateUserTransaction
  include Dry::Transaction

  tee :params
  step :create
  step :send_welcome_email

  private

  def params(input)
    @user_params = input[:user_params]
  end

  def create(input)
    new_user = User.new(@user_params)
    if new_user.save
      Success(input.merge(user: new_user))
    else
      Failure(error: new_user.errors.full_messages)
    end
  end

  def send_welcome_email(input)
    UserMailer.welcome(input[:user].id).deliver_now
      Success(input)
    rescue StandardError => exception
      Failure(error: exception)
  end
end
