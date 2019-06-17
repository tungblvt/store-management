Rails.application.routes.draw do
  get "/login", to:"sessions#new"
  get "static_pages/home"

  post "/login", to:"sessions#create"

  delete "/logout", to: "sessions#destroy"

  resources :users

  scope :admin do
    get "home-admin", to: "admins#home"
    resources :stores
  end
end
