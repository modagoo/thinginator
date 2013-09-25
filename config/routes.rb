Thinginator::Application.routes.draw do

  get '/styleguide' => 'styleguides#index', :as => :style

  get '/file/:id' => 'things#download_file', :as => :download_file

  delete "sign-out" => "sessions#destroy", :as => "sign_out"
  # post "sign-in" => "sessions#new", :as => "sign_in"
  resources :sessions, only: [ :new, :create ]

  resources :things do
    collection do
      get 'test'
      get 'all_the_things'
    end
  end
  resources :collections
  resources :properties
  resources :data_types
  resources :validation_types
  resources :users
  resources :lists
  get '/search' => 'search#index', :as => :search
  get ':slug' => 'things#collection_index', as: :collection_index
  get 'new/:slug' => 'things#new_thing', as: :new_thing_in_collection

  root 'things#index'

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
