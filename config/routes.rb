Rottenpotatoes::Application.routes.draw do
  resources :users do
      get 'open_case', :on => :member
      get 'add_collectible', :on => :member
  end
    
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')

end
