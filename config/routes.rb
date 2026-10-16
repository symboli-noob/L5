Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "top#main"

  resources :users, only: [:index, :new, :create, :destroy]
  resources :tweets, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resource :profile, only: [:show, :new, :create, :edit, :update, :destroy]
  get "top/login", to: "top#login_form", as: :login
  post "top/login", to: "top#login"
  delete "top/logout", to: "top#logout", as: :logout
end