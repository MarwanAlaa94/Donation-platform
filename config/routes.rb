Rails.application.routes.draw do

  get 'admin/home'
  resources :messages
  resources :organizations do
        get '/needs/:id/addImage', to: 'needs#addImage', as: 'addImage'
        post '/addFollower', to: 'followings#create', as: 'create_following'
      post '/destroyFollower', to: 'followings#destroy', as: 'destroy_following'
        resources :needs do
            get 'donation' => 'needs#donate'
            get 'needPayments' => 'needs#showPayments'

            post    'recieve/:id' => 'needs#recieve' , as: 'recieve_pay'
            post    'ignore/:id' => 'needs#ignore' , as: 'ignore_pay'
            get    '/notifications' => 'notifications#create' , as: 'create_noti' #####
            delete  'deleteImage/:image_id' => 'needs#deleteNeedImage' , as: 'delete_image'
        end
        collection do
            get    'notApproved' => 'organizations#notApproved' , as: 'notApproved'
            get    'homePage' => 'organizations#homePage' , as: 'homePage'

            get    'showNotApproved/:id' => 'organizations#showNotApproved' , as: 'showNotApproved'
            post    'approveOrg/:id' => 'organizations#approveOrg' , as: 'approveOrg'
            delete  'disapproveOrg/:id' => 'organizations#disapproveOrg' , as: 'disapproveOrg'
        end
        get 'Achievements' => 'needs#indexAchivements'
  end
  resources :users do
    get '/showPayment' => 'users#showPayment'
    get '/myKheir' => 'users#myKheir'
    get    '/notifications' => 'users#show_all_notifications' , as: 'show_notifications'
  end
  resources :organization_searches
  resources :searches
  root 'organizations#homePage'
  get    '/signUp',   to: 'organizations#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/organization/:id/editImages', to: 'organizations#editAndaddImages', as: 'editImages'
  delete '/organization/:id/deleteImages/:id', to: 'organizations#deleteImage', as: 'deleteImage'
  get    '/donor/register',   to: 'users#new'
  get    '/donor/login',   to: 'sessions#new_donor'
  post   '/donor/login',   to: 'sessions#create_donor'
  delete '/donor/logout',  to: 'sessions#destroy_donor'
  delete '/admin/logout',  to: 'sessions#destroy_admin'
  get    '/admin/invite',  to: 'users#invite_admin'
  post    '/admin/invite',  to: 'users#invite_new_admin'
  get    '/users_admins', to:'users#index_admins'
  post   '/messages/:id/',   to: 'messages#adminReply'
  get 'auth/:provider/callback' => 'sessions#create_donor_provider'
  get 'auth/failure' => redirect('/')


#  root '/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
