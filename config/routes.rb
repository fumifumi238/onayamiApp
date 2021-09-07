Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'integer_literal_descriptions/index'
    end
  end
  get 'integer_literal_descriptions/index'
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
resources :microposts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
