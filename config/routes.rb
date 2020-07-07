# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :users, only: %i[index show]

  resources :chat, only: %i[create show]

  resources :messages
  post '/messages/:id', to: 'messages#create'
end
