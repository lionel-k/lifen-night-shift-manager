Rails.application.routes.draw do
  resources :workers, only: [:new, :create, :edit, :update]
  resources :shifts, only: [:new, :create]
  get 'compute', to: "shifts#compute", as: :compute
  root to: 'pages#home'
end
