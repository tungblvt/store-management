Rails.application.routes.draw do
  get "/login", to:"sessions#new"
  get "static_pages/home"
  get "/admins/home", to: "admins#home"

  post "/login", to:"sessions#create"

  resources :users
end
