# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resource :users, only: [ :destroy ]
  resources :users, only: [ :new, :create ] do
    collection do
      match :session, action: :new_session, via: [ :get ], as: :new_session
      match :session, action: :create_session, via: [ :post ]
      match :session, action: :destroy_session, via: [ :delete ]

      match :password, action: :new_password, via: [ :get ], as: :new_password
      match :password, action: :create_password, via: [ :post ]

      match :profile, action: :edit_profile, via: [ :get ], as: :edit_profile
      match :profile, action: :update_profile, via: [ :put ]

      match :token, action: :edit_token, via: [ :get ], as: :edit_token
      match :token, action: :update_token, via: [ :put ]
    end

    member do
      match :password, action: :edit_password, via: [ :get ], as: :edit_password
      match :password, action: :update_password, via: [ :put ]
    end
  end

  resources :task_lists do
    resources :task_items do
      member do
        put :complete
        put :incomplete
      end
    end
  end

  # Defines the root path route ("/")
  root "users#new_session"
end
