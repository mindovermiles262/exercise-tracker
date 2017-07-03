Rails.application.routes.draw do

  post 'exercises/new'

  resources :users
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'static_pages#index'
  get 'static_pages/index'

  get '/messages', to: 'posts#index'

  get '/leaderboard', to: 'users#leaderboard'

end
