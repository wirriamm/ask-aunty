Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_up: "create_meal", sign_in: "join_meal" },
  controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
