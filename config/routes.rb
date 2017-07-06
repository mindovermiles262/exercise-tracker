Rails.application.routes.draw do

  root 'static_pages#index'

  # Exercises
  post 'exercises/new'
  get '/calendar', to: 'exercises#calendar'

  # Users
  resources :users
  get '/signup', to: 'users#new'
  get '/leaderboard', to: 'users#leaderboard'

  # Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Static Pages
  get 'static_pages/index'

  # Posts
  resources :posts, :only => [:new, :create, :index]
  get '/messages', to: 'posts#index'

end
