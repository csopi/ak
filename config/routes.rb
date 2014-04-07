Ak::Application.routes.draw do
  resources :items
  resources :units
  resources :projects do
    resources :plans
    resources :currents
    collection do
      get "i18n"
    end
  end
  devise_for :users
  root 'pages#index'
end
