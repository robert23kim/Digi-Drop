Rottenpotatoes::Application.routes.draw do
  resources :users do
      get 'open_case', :on => :member
      get 'market', :on => :member
      get 'add_balance', :on => :member
  end
  resources :sessions
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')
  
  #get 'market', to:"users#market", as: 'market'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'signup', to: 'users#new', as: 'signup'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'sell(/:user_id)(/:asset_id)(/:price)', to: 'users#sell', as: 'sell'
  post 'unlist(/:user_id)(/:asset_id)', to: 'users#unlist', as: 'unlist'
  post 'buy(/:buyer_id)(/:seller_id)(/:asset_id)(/:price)', to: 'users#buy', as: 'buy', :constraints => { :price => /.*/ }
  post 'add(/:user_id)(/:case_name)', to: 'users#add', as: 'add'
  match 'open(/:user_id)(/:case_name)' => 'users#open', via: [:get, :post], as: 'open'
end
