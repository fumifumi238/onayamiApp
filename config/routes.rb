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

get 'users/index', to: 'users#index'
get 'users/:id', to: 'users#show', as: 'users_show'
get 'pages/home', to: 'pages#home'
resources :microposts do
  resources :comments, only: [:create]
  resource :likes, only: [:create, :destroy]
end
get 'microposts/:id/comments', to: 'microposts#show'
get 'microposts/tag/:tagname', to: 'microposts#tagname', as: 'tagname'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
