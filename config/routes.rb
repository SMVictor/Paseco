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
      resources :cost_centers
      resources :stalls
    end
  end
  
  root 'welcome#index'
  
end
