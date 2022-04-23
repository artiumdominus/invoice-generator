Rails.application.routes.draw do
  root "sessions#index"

  resource :sessions, only: [:index, :create, :destroy]

  resources :tokens, :invoices
end
