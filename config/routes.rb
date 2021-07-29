Rails.application.routes.draw do
  get '/users/:id/messages', to: 'messages#by_recipient'
  get '/thread/:id', to: 'threads#show'
  get '/thread', to: 'threads#index'

  get '/users/:user_id/thread/:id', to: 'threads#by_recipient'
 
  resources :users 
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
