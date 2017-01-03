Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  resources :projects do
      post 'send_spices', on: :member
      post 'set_status', on: :member
      post 'set_objective_status', on: :member
      post 'assign_spices_to_user', on: :member
      get  'objective_validation', on: :member
      get 'assign_spices', on: :member
  end

  match "/stats", to: "stats#index", via: :get
  match "/stats/spices", to: "stats#spices", via: :get
  match "/stats/users", to: "stats#user_data", via: :get
  match "/stats/project", to: "stats#project", via: :get
  match "/stats/absents", to: "stats#absent", via: :get
  root "projects#index"
end
