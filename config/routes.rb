Rails.application.routes.draw do
  root "home#home"
  resources :articles
  get 'signup', to: 'users#new' #Creates the custom route /signup, render the content from the view users/new
  post 'users', to: 'users#create' #route to execute the action to create a new user, this route does not render a view
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy' #route to delete an item, in the link_to is necessary to include this code: data:{turbo_method: :delete}

end
