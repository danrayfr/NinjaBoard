Rails.application.routes.draw do
  # Routes for regular users

  resources :leaderboards, only: %i[index show]
  resources :certificates, except: :show
  resources :progresses, path: 'progress', only: :index do
    member do
      put :sort
    end
  end

  # resources :assigned_courses do
  #   member do
  #     put :sort
  #   end
  # end

  resources :user_courses do
    member do
      put :sort
    end
  end

  resources :courses, only: %w[index show] do
    resources :lessons do
      post "update_watch_duration", on: :member
    end
  end

  authenticated :user, -> (user) { user.admin? } do
    namespace :admin do
      resources :courses, except: :show
      resources :role_skill_maps, path: 'role-skill-mapping'
    end
  end

  # scope module: :courses, path: :courses, as: :course do
  #   resources :publish, only: :update
  #   resources :unpublish, only: :update
  # end

  resource :checkouts, only: :create
  post '/webhook' => 'webhooks#stripe'

  root 'pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
