Rails.application.routes.draw do
  resources :transactions, only: [:index, :show, :new, :create]
  root "transactions#index"
end
