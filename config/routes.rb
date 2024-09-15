# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  namespace :user do
    resource :sessions, only: [ :destroy ]
    resources :sessions, only: [ :new, :create ]
    resource :registrations, only: [ :destroy ]
    resources :registrations, only: [ :new, :create ]
    resources :passwords, only: [ :new, :create, :edit, :update ]

    namespace :settings do
      resource :profile, only: [ :edit, :update ]
      resource :token, only: [ :edit, :update ]
    end
  end

  namespace :task do
    resources :lists do
      resources :items
      namespace :items do
        resources :complete, only: [ :update ]
        resources :incomplete, only: [ :update ]
      end
    end
  end

  # Defines the root path route ("/")
  root "user/sessions#new"
end
