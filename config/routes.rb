Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations',

      }
devise_scope :user do
  get '/users', to: 'users/sessions#new'
  get '/users/password', to: 'users/passwords#new'
end
  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
