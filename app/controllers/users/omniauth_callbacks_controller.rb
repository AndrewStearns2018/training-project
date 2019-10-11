class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    CreateUserTransaction.new.call(user: @user) do |m|
      m.success do |s|
        sign_in s
        redirect_to root_path
      end
      m.failure do |f|
        render template: 'devise/registrations/new'
      end
    end
  end
end
