Rails.application.routes.draw do
  root "sessions#new"

  resource :sessions, only: [:show, :new, :create, :destroy]

  resources :tokens, only: [:index, :new, :create] do
    member do
      get :activate
    end
  end
  
  resources :invoices

  namespace :api do
    namespace :v1 do
      resources :invoices, except: [:new, :edit]
    end
  end
end
