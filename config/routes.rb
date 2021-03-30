Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/home', to: 'welcome#home')
  get('/about', to: 'welcome#about')
  get('/contact_us', to: 'welcome#contact_us')
  post('/thank_you', to: 'welcome#thank_you')

  #bill splitter
  get '/bill_splitter', to: 'bill_splitter#new'
  post '/calculate_split', to: 'bill_splitter#create'

  # RESTful Product Routes
  get '/products/new', to: 'products#new', as: :new_product
  post '/products', to: 'products#create'
end
