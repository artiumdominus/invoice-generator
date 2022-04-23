Rails.application.routes.draw do
  root "sessions#index"

  resources :sessions, only: [:index, :create, :delete]

  resources :tokens

  resources :invoices do
    collection do
      get :logout
    end
  end
end
