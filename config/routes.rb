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
  match '/itemsum',  to: 'pages#itemsum',  via: 'get'
  get '/projects/:id/projsum', to: 'projects#projsum', as: 'projsum'
  match '/about',   to: 'pages#about',   via: 'get'
  match '/contact',   to: 'pages#contact',   via: 'get'
end