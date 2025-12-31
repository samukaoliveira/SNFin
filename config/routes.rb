Rails.application.routes.draw do
  root "competencias#index"

  resources :competencias
  resources :lancamentos do
    collection do
      get :importar
      post :importar_xls
    end
  end
  resources :cartaos
end
