Rails.application.routes.draw do
  # Routes for regular users
  resources :courses, only: %i[index show]

  namespace :admin do
    resources :courses, except: %i[show]
  end

  # scope module: :courses, path: :courses, as: :course do
  #   resources :publish, only: :update
  #   resources :unpublish, only: :update
  # end

  root 'pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
