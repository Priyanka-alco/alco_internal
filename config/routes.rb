Rails.application.routes.draw do
  # get '*unmatched_route', to: 'application#not_found'
  resources :discounts
  resources :paytm_details
  resources :card_details
  resources :order_details
  resources :orders
  resources :discounts_products
  resources :cities
  resources :states
  resources :countries
  resources :product_details
  resources :products
  resources :customers
  resources :users
  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'packaging_login',to: 'users#packaging_login'
  get 'manager_login',to: 'users#manager_login'
  get 'caller_login',to: 'users#caller_login'
  get 'customer_payment_page',to: 'orders#customer_payment_page'
  get 'product_selling',to: 'products#product_selling'
  get 'single_product_detail',to: 'products#single_product_detail'
  get 'card_details',to: 'products#card_details'
  get 'order',to: 'orders#order'
  get 'search_customer',to: 'customers#search_customer'
  get 'logout',to: 'authentication#logout'
  get 'product_selling_detail' , to:'products#product_selling_detail'
  get 'customer_buy_detail' , to:'products#customer_buy_detail'
  get 'logout' , to:'authentication#logout'
  get 'payment_acknowledgement' , to:'orders#payment_acknowledgement'
  get 'get_caller_history' , to:'orders#get_caller_history'

  post 'update_order_status' , to:'products#update_order_status'
  post 'authenticate', to: 'authentication#authenticate'
  post 'buy_product', to: 'products#buy_product'
  post 'search_by_phone', to: 'customers#search_by_phone'
  post 'edit_customer_detail', to: 'customers#edit_customer_detail'
  post 'payment', to: 'orders#payment'
  # ================operation ========================
  get 'get_address' , to:'orders#get_address'
  get 'all_orders' , to:'orders#all_order'
  get 'bill' , to:'orders#bill'
  get 'completed_order' , to:'orders#completed_order'
  get 'pending_order' , to:'orders#pending_order'
  get 'operation_order_detail' , to:'orders#operation_order_detail'
  post 'complete_order', to: 'orders#complete_order'
  post 'customer_discount', to: 'orders#customer_discount'
  # ===================customer ========================
  get 'customer_home_page' , to:'customers#customer_home_page'
end
