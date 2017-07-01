Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'static_pages/index'

  root 'static_pages#index'

  resources :users
  get '/signup', to: 'users#new'

end
