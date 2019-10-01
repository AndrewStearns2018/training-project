class RegistrationsController < Devise::RegistrationsController

  def create
    CreateUserTransaction.new.call(user_params: user_params) do |m|
      m.success do |s|
        sign_in s[:user]
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
      :password,
      :password_confirmation
      )
  end
end
