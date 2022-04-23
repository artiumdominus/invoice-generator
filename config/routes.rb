Rails.application.routes.draw do
  root "sessions#new"

  resource :sessions, only: [:new, :create, :destroy]

  resources :tokens, only: [:new, :create] do
    member do
      post :activate
    end
  end
  
  resources :invoices

  namespace :api do
    namespace :v1 do
      resources :invoices, except: [:new, :edit]
    end
  end
end
