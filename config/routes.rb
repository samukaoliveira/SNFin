Rails.application.routes.draw do
  devise_for :users
  root "competencias#index"

  resources :competencias
  resources :lancamentos do
    patch :toggle_pago, on: :member
    collection do
      get :importar
      post :importar_xls
    end
  end
  resources :cartaos do
    resources :faturas, only: [ :show ]
    get "faturas", to: "cartaos#faturas"
  end
end
