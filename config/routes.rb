URLShortener::Application.routes.draw do
  devise_for :users

  root :to => 'urls#new'
  
  resources :urls do
    resources :referers
  end
  
  match '/:short_url' => 'urls#show', :constraints => { :short_url => /[A-z0-9]+/ }, :as => 'show'
end
