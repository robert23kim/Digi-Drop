Rottenpotatoes::Application.routes.draw do
  resources :users do
      get 'open_case', :on => :member
      post 'add_asset', :on => :member
  end
  resources :users
  resources :sessions
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')
  
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'signup', to: 'users#new', as: 'singup'
  get 'logout', to: 'sessions#destroy', as: 'logout'

end
