Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # devise_for :users

  get 'authorize' => 'auth#gettoken'

  resources :projects do
      post 'send_spices', on: :member
      post 'set_status', on: :member
      post 'set_objective_status', on: :member
      post 'assign_spices_to_user', on: :member

      get  'objective_validation', on: :member
      get 'assign_spices', on: :member
  end

  match "/projects/remove_user", to: "projects#remove_user_funding", via: :post
  match "/stats/spices", to: "stats#spices", via: :get
  match "/stats/users", to: "stats#user_data", via: :get
  match "/stats/project", to: "stats#project", via: :get
  match "/stats/absents", to: "stats#absent", via: :get
  match "/auth/login", to: "auth#login", via: :get
  match "/auth/logout", to: "auth#logout", via: :delete
  root "projects#index"
end
