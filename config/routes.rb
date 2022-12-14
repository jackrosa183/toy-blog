Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' } 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: redirect('/posts', status: 302)
  # Defines the root path route ("/")
  get '/random_post/', to: 'posts#random_post', as: 'random_post'
  get '/find_users/', to: 'searches#find_users', as: 'find_users'
  get '/model/:type', to: 'threed#model', as: 'model'
  get '/index_drafts', to: "posts#index_drafts"
  get '/index_tags', to: "posts#index_tags"
  get '/find_posts/', to: "searches#find_posts", as: "find_posts"
  get '/featured_posts', to: "posts#index_featured", as: "featured_posts"
  get "users/:id/edit_avatar", to: "users#edit_avatar", as: "edit_user_avatar"
  post "users/:id/update_avatar", to: "users#update_avatar", as: "update_user_avatar"
  get 'json_feed', to: "feed#json_feed"
  get 'rss_feed', to: "feed#rss", format: 'xml'
  get '/auth/twitter/callback', to: "omniauth_callbacks#twitter"
  get '/auth/facebook/callback', to: "omniauth_callbacks#facebook"
  get '/auth/linkedin/callback/', to: "omniauth_callbacks#linkedin"
  get '/add_tag/:id', to: "tags#add", as: "add_tag"
  get '/show_3d/', to: "application#show_3d", as: "show_3d" 
  resources :searches, only: [:index]
  resources :posts do
    collection do
      get :next_page
    end
    resources :comments
  end
  resources :tags, only: [:show, :create]
  resources :users
  resources :avatars, only: [:new, :create, :edit, :update, :destroy]
end
