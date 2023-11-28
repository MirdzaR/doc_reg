Rails.application.routes.draw do
  get 'documents/index'
  get 'documents/new'
  get 'documents/edit'
  get 'documents/delete'
  get 'users/index'
  get 'users/new'
  get 'users/edit'
  get 'users/delete'
  get 'users/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#login"
end
