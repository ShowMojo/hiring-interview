Rails.application.routes.draw do
  root 'transactions#new', type: 'small'

  resources :transactions, only: %i[index show create]

  get 'transactions/new/:type', to: 'transactions#new', as: :new_transaction
end
