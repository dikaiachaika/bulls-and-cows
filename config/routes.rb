Rails.application.routes.draw do
  resources :games, except: [:new] do
    member do
      post 'attempt'
    end
  end
  
  root 'games#index'
end