Ak::Application.routes.draw do
  resources :projects
  devise_for :users
  root 'pages#index'
end
