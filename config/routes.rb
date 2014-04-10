Ak::Application.routes.draw do
  resources :depots, except: :show
  resources :items, except: :destroy
  resources :units, except: :destroy
  resources :projects do
    resources :plans
    resources :currents
    collection do
      get "i18n"
    end
  end
  devise_for :users
  root 'pages#index'
  match '/depotsum', to: 'pages#depotsum', via: 'get'
  get '/projects/:id/projsum', to: 'projects#projsum', as: 'projsum'
end