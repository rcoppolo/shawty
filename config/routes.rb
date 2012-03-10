URLShortener::Application.routes.draw do
  devise_for :users

  root :to => 'urls#new'
  
  # match '/:user_id/url/' => 'urls#index'# , :as => 'your_urls'
  
  resources :urls do
    resources :redirects
  end
  
  match '/:short_url' => 'urls#redirector', :constraints => { :short_url => /[A-z0-9]+/ }, :as => 'redirector'
end
