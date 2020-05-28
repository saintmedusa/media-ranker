Rails.application.routes.draw do
  get 'votes/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "works#top_10"
  resources :works
  get 'works/spotlight', to: 'works#spotlight', as: "spotlight"
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/current_user", to: "users#current", as: "current_user" 
  resources :users, only: [:index, :show]

  post "/votes/create", to: "votes#create", as: "vote_create"
end
