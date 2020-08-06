# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
   }
  root 'top#index'
  resources :users, only: %i[index show]

  resources :chat, only: %i[create show index]

  resources :messages
  post '/messages/:id', to: 'messages#create'
end
