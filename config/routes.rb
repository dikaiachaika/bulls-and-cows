Rails.application.routes.draw do
  resources :games do
    member do
      post 'attempt'
    end
  end
  
  root 'games#index'
end