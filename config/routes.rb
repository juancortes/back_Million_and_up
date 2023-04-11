Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get '/shopping_carts/getProductsId/:id', to: 'shopping_carts#getProductsId', as: 'getProductsId'  
      get '/sales/getCountSaleByProductsId/:id', to: 'sales#getCountSaleByProductsId', as: 'getCountSaleByProductsId'  
      resources :sales 
      resources :products 
      resources :shopping_carts 
    end
  end
end
