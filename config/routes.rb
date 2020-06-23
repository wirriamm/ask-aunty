Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/meals/:id/polls', to: 'meals#setup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
