Rails.application.routes.draw do
  root to: 'dashboard#index'
  resources :dashboard, only: [:index]
  get 'approve', to: 'dashboard#approve' 
  get 'approve_shifts', to: 'dashboard#approve_shifts'
end
