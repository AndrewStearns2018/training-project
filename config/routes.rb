Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations:'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: [:index, :show] do
    resources :contributions, only: [:new, :create] do
      member do
        get :verify_payment
      end
    end
  end
end
