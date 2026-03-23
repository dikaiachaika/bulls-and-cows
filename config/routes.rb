Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  resources :games do
    member do
      post 'attempt'
    end
  end

  resources :users, only: [:edit, :update]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/users", to: "users#create"

  root 'games#index'
end