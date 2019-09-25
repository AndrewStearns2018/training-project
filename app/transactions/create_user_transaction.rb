require "dry/transaction"

class User::CreateUserTransaction
  # This module must be linked to the User class to access its validations.
  include Dry::Transaction

  step :create
  step :send_welcome_email

  private

  def create(input)
    # Returns a success hash if the User passes its validations.
    new_user = User.new(input)
    if new_user.save
      Success(new_user)
    else
      Failure(error: new_user.errors.full_messages.join(' | '))
    end
  end

  def send_welcome_email(input)
    # Will take instance of User from create and send email.
    UserMailer.welcome(input).deliver_now
  end
end
