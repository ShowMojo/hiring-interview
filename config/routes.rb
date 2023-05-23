Rails.application.routes.draw do
  root "transactions#index"

  resources :transactions, only: [:index, :show, :create, :new]
end
