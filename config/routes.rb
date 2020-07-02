Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'

  # get '/home', to: 'pages#home'
  get '/join_makan', to: 'pages#join_meal', as: 'join_makan'
  post '/join_makan', to: 'pages#create_users_meal'
  get '/create_makan', to: 'meals#new', as: 'create_makan'
  # stimulus ajax routes
  get '/join_meal_ajax', to: 'pages#join_meal_ajax'

  get '/meals/:vanity_id/polls', to: 'meals#setup', as: 'setup'
  get '/meals/:vanity_id/result', to: 'meals#result', as: "result"

#   get '/meals/:id/polls', to: 'meals#setup', as: 'setup'
#   get '/meals/:id/result', to: 'meals#result', as: "result"

  resources :meals, only: [:index, :new, :create] do
    resources :polls, only: [:create]
  end

  resources :meals, only: [:new, :create]
  resources :preferences, only: [:index]
  patch '/save_preference', to: 'preferences#save_preference'
end
