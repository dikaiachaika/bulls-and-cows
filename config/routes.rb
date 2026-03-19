Rails.application.routes.draw do
  resources :games do
    member do
      post 'attempt'
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/users", to: "users#create"

  root 'games#index'
end