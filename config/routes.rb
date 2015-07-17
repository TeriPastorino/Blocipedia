Rails.application.routes.draw do
  resources :wikis 

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'welcome#index'

  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :sessions
  resources :password_resets
  resources :charges, only: [:new, :create]

end
