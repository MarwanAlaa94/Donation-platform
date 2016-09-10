Rails.application.routes.draw do

  get 'admin/home'

resources :organizations do
  collection do
    get    'notApproved' => 'organizations#notApproved' , as: 'notApproved'
    get    'showNotApproved/:id' => 'organizations#showNotApproved' , as: 'showNotApproved'
    post    'approveOrg/:id' => 'organizations#approveOrg' , as: 'approveOrg'
  end
end

  resources :messages
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
  get    '/admin/login',   to: 'sessions#new_admin'
  get    '/admin/',   to: 'sessions#new_admin'
  post   '/admin/login',   to: 'sessions#create_admin'
  delete '/admin/logout',  to: 'sessions#destroy_admin'
  
  post   '/admin/home/message/reply',   to: 'admin#reply'
  get 'auth/:provider/callback' => 'sessions#create_donor_provider'
  get 'auth/failure' => redirect('/')


#  root '/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
