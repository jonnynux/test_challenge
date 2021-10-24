Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'home/index'
  resources :products do
    member do
      get :add_to_basket
    end
  end
  resources :baskets do
    collection do
      get :checkout
    end
  end
end
