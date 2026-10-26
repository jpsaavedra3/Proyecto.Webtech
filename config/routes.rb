Rails.application.routes.draw do
  root "pages#home"

  resource :current_user, only: :update

  resources :properties do
    resources :listings, only: [ :new, :create ]
    resources :reviews, only: [ :create ]
  end

  resources :listings, only: [ :index, :show, :edit, :update, :destroy ] do
    member do
      patch :publish
      patch :withdraw
      patch :mark_rented
    end
    resources :applications, only: [ :create ]
  end

  resources :applications, only: [ :index, :show ] do
    member do
      patch :shortlist
      patch :reject
      patch :accept
      patch :withdraw
    end
    resources :visits, only: [ :new, :create ]
  end

  resources :visits, only: [ :edit, :update ] do
    member do
      patch :confirm
      patch :cancel
      patch :complete
    end
  end

  resources :reviews, only: [ :edit, :update, :destroy ]
  resources :neighborhoods
  resources :amenities, except: [ :show ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
  get "up/ready" => "rails/health#ready", as: :rails_health_check_ready
end
