Rails.application.routes.draw do

  #DEVISE ROUTES  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    invitations: 'users/invitations',
    passwords: 'users/passwords'
  }

  authenticated :user do

    root 'admin/pages#home', as: 'authenticated_root'
    
    namespace :admin do
      resources :customers
      resources :stalls
      resources :payments
      resources :employees
      resources :roles
      resources :payroles
      resources :positions
      get 'roles/lines/:id/:stall_id' => 'roles#add_role_lines', as: 'role_lines'
      patch 'roles/lines/:id/:stall_id' => 'roles#update_role_lines', as: 'edit_role_lines'
    end
    namespace :manager do
      resources :roles
    end
  end
  
  root 'home#home'
  
end
