require "dry/transaction"

class User::CreateUserTransaction
  # This module must be linked to the User class to access its validations.
  include Dry::Transaction

  step :validate
  step :create
  step :send_welcome_email

  private

  def validate(user)
    # Returns a success hash if the User passes its validations.
    if user.valid?
      Success(
        # I'm not sure if I need to include user session info, password, etc.
        # Devise should handle that for me.
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        date_of_birth: user.date_of_birth
        )
    else
      Failor("We could not instantiate user.")
    end
  end

  def create(user)
    new_user = User.new(user)
    if new_user.save
      Success(new_user)
    else
      Failor("We could not create this user.")
    # Will take the success hash of the validate method and return an instance of User.
  end

  def send_welcome_email(user)
    # Will take instance of User from create and send email.
    UserMailer.with(user: user).welcome.deliver_now
  end
end
