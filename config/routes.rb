Rails.application.routes.draw do
  get 'microposts/index'
root 'pages#home'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations',

      }
devise_scope :user do
  get '/users', to: 'users/registrations#new'
  get '/users/password', to: 'users/passwords#new'
end
get "users/show" => "users#show"
resources :microposts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
