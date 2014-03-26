Ak::Application.routes.draw do
  devise_for :users
  root 'pages#index'
end
