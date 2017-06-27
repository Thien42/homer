Rails.application.routes.draw do
  #get 'setting/index'

  mount Ckeditor::Engine => '/ckeditor'
  # devise_for :users

  resources :visitor do
    get 'historic', on: :member
  end

  get 'authorize' => 'auth#gettoken'

  match "/projects/finished", to: "projects#finished", via: :get
  resources :projects do
      post 'send_spices', on: :member
      post 'set_status', on: :member
      post 'set_objective_status', on: :member
      post 'assign_spices_to_user', on: :member

      get  'objective_validation', on: :member
      get 'assign_spices', on: :member
      get 'clone', on: :member
      get 'historic', on: :member
  end

  match "/projects/remove_user", to: "projects#remove_user_funding", via: :post
  match "/stats/spices", to: "stats#spices", via: :get
  match "/stats/users", to: "stats#user_data", via: :get
  match "/stats/project", to: "stats#project", via: :get
  match "/stats/admin", to: "stats#admin", via: :get
  match "/stats/change_status", to: "stats#change_status", via: :post
  match "/auth/login", to: "auth#login", via: :get
  match "/auth/logout", to: "auth#logout", via: :delete

  match "/setting", to: "setting#index", via: :get
  match "/setting", to: "setting#create", via: :post

  root "projects#index"
end
