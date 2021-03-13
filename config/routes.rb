Rottenpotatoes::Application.routes.draw do
  resources :users
  # map '/' to be a redirect to '/users'
  root :to => redirect('/users')
end
