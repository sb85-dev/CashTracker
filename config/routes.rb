Rails.application.routes.draw do
  
  resources :accounts do
    member do
      get 'budget'
    end
    resources :invites, only: [:create]
    resources :incomes, only: [:new, :create, :edit, :update, :destroy]
    resources :expenses, only: [:new, :create, :edit, :update, :destroy]
    resources :transactions
  end
  devise_for :users


  get 'invites/:token', to: 'invites#show', as: 'invite'
  post 'invites/:token/accept', to: 'invites#accept', as: 'accept_invite'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'accounts#index', as: :authenticated_root
  end
  
  unauthenticated do
    root to: 'pages#home', as: :unauthenticated_root
  end
end
