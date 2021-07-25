Rails.application.routes.draw do
  resources :users do
    resources :messages
  end
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
