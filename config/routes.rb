Rails.application.routes.draw do
  root "sessions#new"

  resource :sessions, only: %i(show new create destroy)

  resources :tokens, only: %i(index new create) do
    member do
      get :activate
    end
  end
  
  resources :invoices, except: :destroy do
    member do
      get :download
    end
    collection do
      get :not_found
    end
  end

  namespace :api do
    namespace :v1 do
      resources :invoices, except: %i(new edit destroy)
    end
  end
end
