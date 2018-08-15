Rails.application.routes.draw do
  devise_for :users, controllers: {registrations:'users/registrations'}
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts
#   # 검색 액션
#   resources :posts do
#   collection do
#     get :search
#   end
# end
  # get 'posts/search' => 'posts#search'
  
  # 홈페이지를 들어오자마자 먼저 로그인하도록 root를 설정
  root 'posts#index'
  get '/images' => 'images#new'
  post '/tinymce_assets' => 'tinymce_assets#create'
  get '/notice' => 'posts#notice'
  # get '/list' => 'posts#list'
  get '/homework' => 'posts#homework'
  get '/lecture' => 'posts#lecture'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
