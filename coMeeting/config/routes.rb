CoMeeting::Application.routes.draw do

	get "meetings/get_admin_circles"
	
	get "meetings/get_minutes"
	
	post "meetings/update_minutes"
	
	post "meetings/update_action_item"
	
	post "participations/send_email" => "participations#send_email", :as => "send_email"

	scope "(:locale)", :locale => /en|pt/ do
		
		get "meetings/:id/confirm" => "participations#confirm", :as => "confirm_participation"
	
		get "meetings/:id/decline" => "participations#decline", :as => "decline_participation"
	
		get "meetings/:id/download_pdf" => "meetings#download_pdf", :as => "download_pdf"
	
		resources :meetings
		
		# get "/:page" => "static#show", :as => 'static'
		
		root :to => 'home#index'
	end
	
	#match '/:anything' => redirect("/"), :constraints => { :anything => /.*/ }
  # The priority is based upon order of creation:
  # first created -> highest priority.

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
