Rails.application.routes.draw do
  root "homes#index"

  get "/login", to:"sessions#new"
  get "static_pages/index"
  get "/search", to:"products#search"
  get "search_product_cate/:id", to: "products#search_by_cate", as: "search_by_cate"
  get "/store/:id", to: "stores#detail", as: "store_detail"
  get "/your-cart", to: "orders#user_order"
  get "/user-info/:id", to: "users#user_info", as: "user_info"
  get "/checkout", to: "orders#checkout", as: "checkout"
  post "/post-checkout", to: "orders#post_checkout", as: "post_checkout"

  post "/login", to:"sessions#create"
  post "/user_order", to: "orders#user_order"

  delete "/logout", to: "sessions#destroy"

  resources :comments
  resource :cart, only: :show
  resources :order_details

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
