Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/contact_us", to: "welcome#contact_us")
  post("/thank_you", to: "welcome#thank_you")

  #bill splitter
  get "/bill_splitter", to: "bill_splitter#new"
  post "/calculate_split", to: "bill_splitter#create"

  # Session Routes
  resource :session, only: [:new, :create, :destroy]

  # RESTful Product Routes
  #  get '/products/new', to: 'products#new', as: :new_product
  #  post '/products', to: 'products#create'
  #  get '/products/:id', to: 'products#show', as: :product
  #  get '/products', to: 'products#index'
  #  delete '/products/:id', to: 'products#destroy'
  #  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  #  patch '/products/:id', to: 'products#update'

  # Here are the routes for our API
  namespace :api, defaults: { format: :json } do #👈🏻 we can set default response format of the block
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resource :session, only: [:create, :destroy]
      get("/current_user", to: "sessions#get_current_user")
      resources :users, only: [:create] do
        get :current, on: :collection
      end
    end
    match "*unmatched_route", to: "application#not_found", via: :all
  end

  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :users, only: [:new, :create, :show]

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  resources :news_articles
end
