Rails.application.routes.draw do

  root 'static_pages#index'
  
  get 'static_pages/index'

  resources :users
  get '/signup', to: 'users#new'

end
