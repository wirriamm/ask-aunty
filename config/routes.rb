Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/meals/:id/polls', to: 'meals#setup', as: 'setup'
  get '/meals/:id/result', to: 'meals#result', as: "result"

  resources :meals, only: [:new, :create] do
    resources :polls, only: [:create]
  end

  get '/join_meal', to: 'pages#join_meal'
  post '/join_meal', to: 'pages#create_users_meal'

  resources :preferences, only: [:index]
  post '/preferences', to: 'preferences#save_preferences'
end
