class RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new(user_params)
    CreateUserTransaction.new.call(user: user) do |m|
      m.success do |s|
        sign_in s
        redirect_to root_path
      end
      m.failure do |f|
        @errors = f[:error]
        @user = User.new(user_params)
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :date_of_birth,
      :country_of_residence,
      :nationality,
      :password,
      :password_confirmation
      )
  end
end
