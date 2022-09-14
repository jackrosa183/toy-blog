Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
  # Defines the root path route ("/")
  get '/index_drafts', to: "posts#index_drafts"
  resources :posts do
    resources :comments
  end
  resources :users
end
