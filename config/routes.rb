Rails.application.routes.draw do

  resources :organizations do
    resources :needs
    get 'Achievements' => 'needs#indexAchivements'
  end
  resources :users
  resources :organization_searches
  root 'organizations#index'
  get 'needs', to:'needs#index'
  get 'achiev' , to:'needs#indexAchivements'
  get    '/signUp',   to: 'organizations#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/organization/:id/editImages', to: 'organizations#editAndaddImages', as: 'editImages'
  get    '/donor/register',   to: 'users#new'
  get    '/donor/login',   to: 'sessions#new_donor'
  post   '/donor/login',   to: 'sessions#create_donor'
  delete '/donor/logout',  to: 'sessions#destroy_donor'

  match '/contacts',     to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]
  get 'auth/:provider/callback' => 'sessions#create_donor_provider'
  get 'auth/failure' => redirect('/')


#  root '/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
