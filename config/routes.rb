CartCallWeb::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :course
  # Required Params: latitude, longitude as floating point
  match '/course/find/closest' => 'course#find_course', :as => 'find_courses'
  # Required Params: course_id as integer
  post '/course/availability' => 'course#availability'
  match '/course/:course_id/availability' => 'course#availability', :as => 'availability'
  # Required Params: latitude, longitude as floating point && course_id as integer
  match '/course/summon/request' => 'course#summon_cart', :as => 'summon_cart'
  # Required Params: summon_id
  post '/course/summon/accept' => 'course#accept_summon'
  match '/course/summon/:summon_id/accept' => 'course#accept_summon', :as => 'accept_summon'
  # Required Params: summon_id
  post '/course/summon/serve' => 'course#serve_summon'
  match '/course/summon/:summon_id/serve' => 'course#serve_summon', :as => 'serve_summon'
  
  #Required Params: course_pin as integer
  post '/course/cart/login' => 'course#login'
  post '/course/cart/get/summons' => 'course#get_summons'
  
  resources :golfer
  match '/golfer/update/position' => 'golfer#update_position'
  match '/course/summon/view/:summon_id/map' => 'index#view_summoner_on_map', :as => "view_summon"
  
  resources :admin
  match '/admin' => 'admin#index'
  match '/pusher/webhooks' => 'admin#webhooks'
  
  resources :index
  match '/cart' => 'index#cart_view'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'index#summoner_view'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
