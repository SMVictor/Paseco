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
      resources :positions
      resources :bncr_infos
      resources :bac_infos

      get    'roles/lines/:id/:stall_id'                        => 'roles#add_role_lines',    as: 'role_lines'
      patch  'roles/lines/:id/:stall_id'                        => 'roles#update_role_lines', as: 'edit_role_lines'

      get    'roles/approvals/:id'                              => 'roles#approvals',         as: 'role_approvals'
      get    'roles/approvals/:id/:stall_id'                    => 'roles#check_changes',     as: 'check_role_changes'
      get    'roles/approvals/add/:id/:stall_id/:change_id'     => 'roles#approve_create',    as: 'approve_create'
      get    'roles/approvals/update/:id/:stall_id/:change_id'  => 'roles#approve_update',    as: 'approve_update'
      get    'roles/approvals/destroy/:id/:stall_id/:change_id' => 'roles#approve_destroy',   as: 'approve_destroy'
      get    'roles/approvals/deny/:id/:stall_id/:change_id'    => 'roles#deny_change',       as: 'deny_change'

      get    'payroles'      => 'roles#index_payroles', as: 'payroles'
      get    'payroles/:id'  => 'roles#show_payroles',  as: 'payrole'
      get    'BNCR/file/:id' => 'roles#bncr_file',      as: 'bncr_file'
      get    'BAC/file/:id'  => 'roles#bac_file',       as: 'bac_file'

    end
  end
  
  root 'home#home'
  
end
