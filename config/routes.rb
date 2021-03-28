Rottenpotatoes::Application.routes.draw do
  resources :users do
      get 'open_case', :on => :member
      post 'add_asset', :on => :member
  end
  resources :sessions
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')
  
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'signup', to: 'users#new', as: 'signup'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'sell(/:user_id)(/:collectible_id)(/:price)', to: 'users#sell', as: 'sell'

end
