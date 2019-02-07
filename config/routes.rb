Rails.application.routes.draw do

  resources :role_lines_copies
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

      get    'roles/lines/:id/:stall_id'                        => 'roles#add_role_lines',    as: 'role_lines'
      patch  'roles/lines/:id/:stall_id'                        => 'roles#update_role_lines', as: 'edit_role_lines'

      get    'roles/approvals/:id'                              => 'roles#approvals',         as: 'role_approvals'
      get    'roles/approvals/:id/:stall_id'                    => 'roles#check_changes',     as: 'check_role_changes'
      get    'roles/approvals/add/:id/:stall_id/:change_id'     => 'roles#approve_create',    as: 'approve_create'
      get    'roles/approvals/update/:id/:stall_id/:change_id'  => 'roles#approve_update',    as: 'approve_update'
      get    'roles/approvals/destroy/:id/:stall_id/:change_id' => 'roles#approve_destroy',   as: 'approve_destroy'
      get    'roles/approvals/deny/:id/:stall_id/:change_id'    => 'roles#deny_change',       as: 'deny_change'
    end
  end
  
  root 'home#home'
  
end
