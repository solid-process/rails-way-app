# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resource :user_sessions, only: [ :destroy ]
  resources :user_sessions, only: [ :new, :create ]
  resource :user_registrations, only: [ :destroy ]
  resources :user_registrations, only: [ :new, :create ]
  resources :user_passwords, only: [ :new, :create, :edit, :update ]
  resource :user_profiles, only: [ :edit, :update ]
  resource :user_tokens, only: [ :edit, :update ]

  resources :task_lists do
    resources :task_items
    resources :complete_task_items, only: [ :update ]
    resources :incomplete_task_items, only: [ :update ]
  end

  # Defines the root path route ("/")
  root "user_sessions#new"
end
