Rails.application.routes.draw do
  root "home#index"

  resource :session
  resources :passwords, param: :token

  # Health check endpoint for load balancers and uptime monitors
  get "up" => "rails/health#show", as: :rails_health_check
end
