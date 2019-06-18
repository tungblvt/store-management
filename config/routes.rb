Rails.application.routes.draw do
  get "/login", to:"sessions#new"
  get "static_pages/home"

  post "/login", to:"sessions#create"

  delete "/logout", to: "sessions#destroy"

  scope :admin do
    get "home-admin", to: "admins#home"

    resources :stores
    resources :users
    resources :categories

    post "/unlock-store", to: "stores#unlock"
    post "/lock-store", to: "stores#lock"
  end
end
