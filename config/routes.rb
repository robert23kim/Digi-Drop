Rottenpotatoes::Application.routes.draw do
  resources :users
  # map '/' to be a redirect to '/movies'
  # root :to => redirect('/users')
end
