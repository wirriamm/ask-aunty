Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/meals/:id/polls', to: 'meals#setup', as: 'setup'
  get '/meals/:id/result', to: 'meals#result', as: "result"

  resources :meals, only: [:new, :create] do
    resources :polls, only: [:create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/join_meal', to: 'pages#join_meal'
  get '/create_meal', to: 'pages#create_meal'

  resources :meals, only: [:new, :create]
  resources :preferences, only: [:index, :create, :update]
end
