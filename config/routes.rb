Rails.application.routes.draw do
  # Main page (to be implemented)
  # root to: ''
  
  # Signup routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Login/logout routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Admin page for URL CRUD
  resources :shortened_urls, path: 'my-urls'

  # Anything else should be a reference to a shortened url
  get '/*short_uri', to: 'redirect#index'
end
