Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  get '/my_address', to: 'addresses#show', as: :my_address
  resource :addresses, only: [:create]

  namespace :api do
    post '/login', to: 'sessions#create', as: :login

    get '/my_address', to: 'addresses#show', as: :my_address
    resource :addresses, only: [:create]
  end

  root to: "addresses#show"
end
