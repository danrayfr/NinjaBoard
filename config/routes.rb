Rails.application.routes.draw do
  # Routes for super_admin users
  devise_for :super_admins, skip: :registrations

  authenticated :super_admin_user do
    root to: "super_admin#index", as: :super_admin_root
  end

  get "super-admin" => "super_admin#index"
  namespace :super_admin, path: 'super-admin' do
    resources :users do
      member do
        patch :ban
        patch :unban
      end
    end
    resources :role_skill_maps, path: 'role-skill-mapping'
    resources :courses do
      resources :lessons
    end
  end

  patch 'super-admin/courses/:course_id/lessons/:id/move' => 'super_admin/lessons#move'
  # Routes for regular users

  resources :leaderboards, only: %i[index show]
  resources :certificates, except: :show
  resources :progresses, path: 'progress', only: :index do
    member do
      put :sort
    end
  end

  resources :logins, only: %i[index destroy], path: "active-sessions"

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

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'pages#home'
end
