Rails.application.routes.draw do
  get 'projects/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations:'registrations' }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
