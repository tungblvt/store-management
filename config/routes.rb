Rails.application.routes.draw do
  root "homes#index"

  get "/login", to:"sessions#new"
  get "static_pages/index"
  get "/search", to:"products#search"
  get "/store/:id", to: "stores#detail", as: "store_detail"

  post "/login", to:"sessions#create"

  delete "/logout", to: "sessions#destroy"

  scope :admin do
    get "home-admin", to: "admins#home"

    post "/unlock-store", to: "stores#unlock"
    post "/lock-store", to: "stores#lock"

    resources :stores
    resources :products
    resources :users
    resources :categories
    resources :orders
  end
end
