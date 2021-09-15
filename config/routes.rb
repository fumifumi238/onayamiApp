Rails.application.routes.draw do
root 'microposts#index'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations',

      }
devise_scope :user do
  get '/users', to: 'users/registrations#new'
  get '/users/password', to: 'users/passwords#new'
end

get 'users/show', to: 'users#show'
get 'pages/home', to: 'pages#home'
resources :microposts do
  resources :comments, only: [:create]
  resource :likes, only: [:create, :destroy]
end
get 'microposts/:id/comments', to: 'microposts#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
