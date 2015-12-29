Rails.application.routes.draw do
  get 'user_comment_rating/rateit'

  devise_for :users
  resources :ratings
  resources :tags
  resources :comments
  resources :topics
  resources :posts
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  
 root 'topics#index'
   
   
   resources :topics do
       resources :posts
     end

	  resources :posts do
       resources :comments
    end
  resources :posts do
    resources :ratings
  end

  post 'posts/update_post'
  post 'posts/alert'
  match '/user' => "posts#user" ,via: :get
  get 'comments/:id/rate' => 'comments#rate', as: :rate
  patch 'comments/:id/rating' => 'comments#rating', as: :commentrating
  patch 'posts/:id/rating' => 'posts#rating', as: :postrating
  get 'topics/device' => 'topics#', as: :device
  #match 'posts/posts/update_post' => "posts#update_post", :as => :login ,via: :get

  devise_scope :user do
    match '/sign-in' => "devise/sessions#new", :as => :login ,via: :get
  end
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
