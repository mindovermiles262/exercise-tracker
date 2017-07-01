Rails.application.routes.draw do

  root 'users#index'

  resources :users
  get '/signup', to: 'users#new'

end
