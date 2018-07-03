Rails.application.routes.draw do
  resources :steps
  resources :operations
  resources :crop_operations
  resources :livestock_operations
  resources :crop_inventories
  resources :livestock_inventories
  root to: 'counties#index'
  get '/counties/multiple', to: 'counties#show_multiple'
  resources :counties, only: [:index, :show] do
    resources :statistics, only: [:index]
  end
  resources :statistics, only: [:show]
  resources :energy_units, only: [:index]

  get '/crop_assumptions', to: 'application#crop_assumptions'
  get '/livestock_assumptions', to: 'application#livestock_assumptions'

  get '/links', to: 'application#links'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
