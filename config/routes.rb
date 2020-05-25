Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "works#top_10"
  resources :works
  get 'works/top', to: 'works#top_10', as: 'top_works'
  resources :users, only: [:index, :show, :new, :create]
end
