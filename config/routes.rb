Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  post 'home/index'   #장바구니페이지
  post 'user/sign_in'
  post 'home/folder'
  post 'home/fol_add'
  post 'home/fol_del'
  post 'home/fol_chan'
  post 'home/in_cart'   #장바구니에 담을 정보 입력하는 페이지
  post 'home/in_cart2'   #in_cart정보 넘어가는 곳
  post 'home/purchase'   #구매한 목록 페이지
  post 'home/purchase2'   #장바구니에서 구매한 목록으로 넘어가는 곳
  post 'home/to_cart'   #구매한 목록에서 장바구니로 넘어가는 곳
  post 'home/delete'   #장바구니에서 삭제되는 곳
  get 'home/index'
  post 'home/p_delete'   #구매목록에서 삭제되는 곳
  get 'home/cart'
  get 'home/:fol_id/folder2'=>"home#folder2"
  get 'home/:fol_id/folder3'=>"home#folder3"
  post 'home/:cart_id/edit'=>"home#edit"
  get 'home/:cart_id/edit'=>"home#edit"
  post 'home/:cart_id/edit2'=>"home#edit2"
  get 'home/in_cart'
  get 'home/folder'
  get 'home/purchase'
  get 'home/bookmark'
  post 'home/book_add'
  post 'home/book_del'
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
