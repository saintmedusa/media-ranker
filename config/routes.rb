Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "works#top_10"
  resources :works
  get 'works/top', to: 'works#top_10', as: 'top_works'
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/current_user", to: "users#current", as: "current_user" 
  resources :users, only: [:index, :show]
end
