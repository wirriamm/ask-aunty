Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/meals/:id/polls', to: 'meals#setup'
  get '/meals/:id/result', to: 'meals#result'

  resources :meals, only: [:new, :create] do
    resources :polls, only: [:create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
