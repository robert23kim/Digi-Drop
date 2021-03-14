Rottenpotatoes::Application.routes.draw do
  resources :users do
      get 'open_case', :on => :member
      post 'add_asset', :on => :member
  end
    
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')

end
