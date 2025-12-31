Rails.application.routes.draw do
  root "competencias#index"

  resources :competencias
  resources :lancamentos
  resources :cartaos
end
