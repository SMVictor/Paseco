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
      resources :ccss_payments

      get    'roles/lines/:id/:stall_id/:employee_id'           => 'roles#add_role_lines',    as: 'role_lines'
      patch  'roles/lines/:id/:stall_id/:employee_id'           => 'roles#update_role_lines', as: 'edit_role_lines'

      get    'roles/approvals/:id'                              => 'roles#approvals',         as: 'role_approvals'
      get    'roles/approvals/:id/:stall_id'                    => 'roles#check_changes',     as: 'check_role_changes'
      get    'roles/approvals/add/:id/:stall_id/:change_id'     => 'roles#approve_create',    as: 'approve_create'
      get    'roles/approvals/update/:id/:stall_id/:change_id'  => 'roles#approve_update',    as: 'approve_update'
      get    'roles/approvals/destroy/:id/:stall_id/:change_id' => 'roles#approve_destroy',   as: 'approve_destroy'
      get    'roles/approvals/deny/:id/:stall_id/:change_id'    => 'roles#deny_change',       as: 'deny_change'

      get    'payroles'                  => 'roles#index_payroles',     as: 'payroles'
      get    'payroles/:id'              => 'roles#show_payroles',      as: 'payrole'
      get    'payroles/:id/old'          => 'roles#show_old_payrole',  as: 'old_payrole'
      get    'payroles/:id/:employee_id' => 'roles#payrole_detail',     as: 'payrole_detail'

      get    'BNCR/file/:id' => 'roles#bncr_file',      as: 'bncr_file'
      get    'BAC/file/:id'  => 'roles#bac_file',       as: 'bac_file'

      get    'inactive/customers'          => 'customers#inactives',        as: 'inactive_customers'
      get    'inactive/customers/:id'      => 'customers#show_inactive',    as: 'show_inactive_customer'
      get    'inactive/customers/:id/edit' => 'customers#edit_inactive',    as: 'edit_inactive_customer'
      patch  'inactive/customers/:id/edit' => 'customers#update_inactive',  as: 'update_inactive_customer'
      delete 'inactive/customers/:id/edit' => 'customers#destroy_inactive', as: 'delete_inactive_customer'

      get    'inactive/stalls'          => 'stalls#inactives',        as: 'inactive_stalls'
      get    'inactive/stalls/:id'      => 'stalls#show_inactive',    as: 'show_inactive_stall'
      get    'inactive/stalls/:id/edit' => 'stalls#edit_inactive',    as: 'edit_inactive_stall'
      patch  'inactive/stalls/:id/edit' => 'stalls#update_inactive',  as: 'update_inactive_stall'
      delete 'inactive/stalls/:id/edit' => 'stalls#destroy_inactive', as: 'delete_inactive_stall'

      get    'inactive/employees'          => 'employees#inactives',        as: 'inactive_employees'
      get    'inactive/employees/:id'      => 'employees#show_inactive',    as: 'show_inactive_employee'
      get    'inactive/employees/:id/edit' => 'employees#edit_inactive',    as: 'edit_inactive_employee'
      patch  'inactive/employees/:id/edit' => 'employees#update_inactive',  as: 'update_inactive_employee'
      delete 'inactive/employees/:id/edit' => 'employees#destroy_inactive', as: 'delete_inactive_employee'

      get    'roles/:id/stalls/:stall_id'  => 'roles#stall_summary',        as: 'stall_summary'

      get    'payroles/:id/stalls/hours'   => 'roles#stalls_hours',         as: 'stalls_hours'

    end
  end
  
  root 'home#home'
  get '*path' => redirect('/')
  
end
