Ak::Application.routes.draw do
  resources :items

  resources :units

  resources :projects
  devise_for :users
  root 'pages#index'
end
