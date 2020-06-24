Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/meals/:id/polls', to: 'meals#setup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/join_meal', to: 'pages#join_meal'
  post '/join_meal', to: 'pages#create_users_meal'

  resources :meals, only: [:new, :create]
end
