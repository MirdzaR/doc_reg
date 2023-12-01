Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "documents#index"

  resources :documents do
    member do
      delete :remove_attachment
    end
  end
  resources :users, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
