Cantina::Application.routes.draw do
  
  resources :reboot_requests, :only => [:index, :show, :create, :new ]

  resources :manufacturer_snom, :only => [:index ]
  resources :manufacturer_aastra, :only => [:index ]
  resources :manufacturer_tiptel, :only => [:index ]
  
  resources :provisioning_log_entries, :only => [:index, :show]

  match 'aastra/:mac_address.cfg'  => 'manufacturer_aastra#show', :format => 'txt'
  match 'tiptel/:mac_address.cfg'  => 'manufacturer_tiptel#show', :format => 'txt'
  match 'snom/:mac_address.cfg'  => 'manufacturer_snom#show', :format => 'xml'

  get "pages/index"
  
  root :to => "pages#index"

  resources :phone_model_mac_addresses

  resources :phone_keys

  match 'phones/:id/reboot' => 'phones#reboot', :as => :phone_reboot

  # http://guides.rubyonrails.org/routing.html#nested-resources
  resources :phones do
    resources :sip_accounts
  end

  resources :sip_accounts

  resources :codecs

  resources :sip_account_codecs

  resources :phone_key_function_definitions

  resources :phone_model_keys

  resources :manufacturers do
    resources :phone_models
  end

  resources :phone_models do
    resources :phones
  end

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
