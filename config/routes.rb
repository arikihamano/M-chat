Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :users, only: %i(index show)

  resources :chat, only: %i(create show)
  get  "chat/"  => "messages#show"
end
