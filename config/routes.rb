Rails.application.routes.draw do
  get "/login", to:"session#new"
  post "/login", to:"session#create"
end
