Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'

  # get '/home', to: 'pages#home'
  get '/join_meal', to: 'pages#join_meal'
  post '/join_meal', to: 'pages#create_users_meal'
  get '/create_meal', to: 'meals#new'

  get '/meals/:vanity_id/polls', to: 'meals#setup', as: 'setup'
  get '/meals/:vanity_id/result', to: 'meals#result', as: "result"

  resources :meals, only: [:index, :new, :create] do
    resources :polls, only: [:create]
  end

  resources :preferences, only: [:index]
  patch '/save_preference', to: 'preferences#save_preference'
end
