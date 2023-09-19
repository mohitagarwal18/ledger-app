Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'transactions/:entity_id', to: 'transactions#index', as: :entity_transactions
  
  root to:  redirect("transactions/76510190788")
end
