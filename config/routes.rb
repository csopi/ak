Ak::Application.routes.draw do
  resources :items
  resources :units
  resources :projects do
    resources :plans
  end
  devise_for :users
  root 'pages#index'
end
