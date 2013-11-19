# -*- encoding : utf-8 -*-
Nextdoorz::Application.routes.draw do
  # Redirect to the user page when accessing the route of the website
  root :to => "users#home"

  # TODO: clean the routes and rearrange them

  get "/users/wordpress" => "users#wordpress"
  get "/users/wordpress_callback" => "users#wordpress_callback"
  get "/users/blogger" => "users#blogger"
  match "/users/blogger_callback" => "users#blogger_callback"

  get '/pro' => 'stores#new', :as => :pro_home


  get '/stores/:id/stocks' => 'stocks#index'
  get '/user(/*path)' => 'static#show', defaults: {permalink: 'empty'}, :as => :user_home

  devise_for :users, :controllers => {
    :passwords => 'users/passwords',
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => 'users/sessions'}

  post 'users/create' => 'users#create'
  

  #post 'boards/temporary' => 'boards#set_temporary'
  #get 'boards/temporary' => 'boards#get_temporary'

  resources :boards, except: [:new, :edit]

  resources :deals, except: [:new, :edit] do
    get 'to_jangalist', to: "deals#add_to_wishlist"
    delete 'from_jangalist', to: "deals#remove_from_wishlist"
  end

  resources :products, except: [:new, :edit] do
    get 'to_jangalist', to: "products#add_to_wishlist"
    delete 'from_jangalist', to: "products#remove_from_wishlist"
  end

  resources :news, except: [:edit]
  
  ##
  # Store routes
  resources :stores, except: :destroy do
    post '' => 'stores#update'
    get ":id/stocks" => "stores#stocks", :as => :store_stocks
    resources :news, only: :index
    resources :tags, only: :index
    resources :products, only: :index
    resources :deals, only: :index
    resources :follows, only: [:new, :index] do
      delete 'destroy', on: :collection
    end
    resources :pictures, except: [:edit]
  end
  get "deleted", :to => "stores#erased", :as => :stores_erased  
  ##
  
  resources :pictures, only: [:show]
  resources :category_parents, only: :index
  resources :tags, only: :index
  resources :users
  resources :categories, only: :index do
    resources :stores, only: :index
  end

  resources :follows, only: [:create, :index] do
    collection do
      get "news", to: "news#index", defaults: {followed: true}
      get "deals", to: "deals#index", defaults: {followed: true}
      get "products", to: "products#index", defaults: {followed: true}
    end
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  # Special routes
  get 'jangalist', to: "wishlist#index"
  get "static(/:permalink)" => "static#show", as: :static
  #get "user_static(/:permalink)" => "static#show", as: :user_static
  #get 'profile' => 'users#edit', :as => 'edit_user'
  #post 'profile/update' => 'users#update'

  get 'user/signup', as: 'user_signup'
  get 'user/signin', as: 'user_signin'
  get 'profile' => 'users#profile', :as => 'user_profile'
  
  post "users/send-store-invitation" => "users#send_store_invitation"
  post "users/recommend" => "users#recommend"

  get "*path", to: "static#show", defaults: {permalink: '404'}
end
