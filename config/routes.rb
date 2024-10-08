Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :bookings, only: [:index,:show]
  resources :hotels do
    resources :bookings, only: [:new, :create, :show] do
      resources :payments, only: [:new, :create, :index]
      get 'payments/complete', to: 'payments#complete'
    end
  end
  resources :hotels
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  post 'ai/generate_description', to: 'ai#generate_description'

  # Defines the root path route ("/")
  resources :users do
    post 'create_chat', on: :member
    resources :chats, only: [:index, :show] do
      resources :messages, only: [:create]
    end
    get :previous_bookings, on: :member
  end
end
