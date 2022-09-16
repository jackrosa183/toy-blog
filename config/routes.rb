Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "posts#index"
  # Defines the root path route ("/")
  get '/index_drafts', to: "posts#index_drafts"
  get '/index_tags', to: "posts#index_tags"
  resources :searches, only: [:index]
  resources :posts do
    resources :comments
  end
  resources :tags, only: [:show, :create]
  resources :users
end
