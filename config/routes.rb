
Rails.application.routes.draw do  
  resources :charges

  resources :listings

  post 'listings/:id', to: 'listings#show'

  root :to => 'pages#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => 'users/registrations' }

  resources :users, only: [:show]

  resources :photos, only: [:create, :destroy] do
    collection do
      get :list 
    end
  end

  resources :articles, only: [:create, :destroy, :show] do
    collection do
      get :list 
    end
  end

  resources :listings do 
    resources :reservations, only: [:new, :create]
  end

  resources :listings do 
    resources :charges, only: [:new, :create]
  end

  resources :listings do
    resources :reviews, only: [:create, :destroy]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  

  get 'manage-listing/:id/basics' => 'listings#basics', as: 'manage_listing_basics'
  get 'manage-listing/:id/goalprice' => 'listings#goalprice', as: 'manage_listing_goalprice'
  get 'manage-listing/:id/perprice' => 'listings#perprice', as: 'manage_listing_perprice'
  get 'manage-listing/:id/address' => 'listings#address', as: 'manage_listing_address'
  get 'manage-listing/:id/photos' => 'listings#photos', as: 'manage_listing_photos'
  get 'manage-listing/:id/genre' => 'listings#genre', as: 'manage_listing_genre'  

  get 'manage-listing/:id/articles' => 'listings#articles', as: 'manage_listing_articles'

  get 'manage-listing/:id/bankaccount' => 'listings#bankaccount', as: 'manage_listing_bankaccount'
  get 'manage-listing/:id/publish' => 'listings#publish', as: 'manage_listing_publish'

  get '/connect/confirm' => 'stripe#confirm', as: 'stripe_confirm'
  get '/connect/deauthorize' => 'stripe#deauthorize', as: 'stripe_deauthorize'

  get '/not_checked' => 'listings#not_checked'

  get '/search' => 'pages#search'

  get '/ajaxsearch' => 'pages#ajaxsearch'
  get '/howtouse' =>'pages#howtouse'
  
end



