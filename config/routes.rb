TwitchClone::Application.routes.draw do

  resources :users, only: [:new, :create, :update] do
    get "/follows", to: "users#follows"
  end
  resources :pages, only: [:update] do
    resources :moderators, only: [:create]
    delete "/moderators/:user_id", to: "moderators#destroy"
    post "/subscription", to: "subscriptions#subscribe"
  end
  resources :follows, only: [:create, :destroy]
  put "/follows/:followee_id", to: "follows#update", as: "follow"
  resources :videos, except: [:index, :new] do
    resources :comments, only: [:create, :update]
  end

  resources :containers, only: [:destroy]
  resources :watchings, only: [:create, :destroy]


  resource :session, only: [:new, :create, :destroy]

  post "/chat", to: "chats#chat", as: "chat"
  post "/chat_silence", to: "chats#silence", as: "silence"
  post "/chat_watch", to: "chats#start_watching", as: "watch"
  delete "/chat_leave/:page_name", to: "chats#stop_watching", as: "leave"
  get "/404", to: "static_pages#not_found", as: "not_found"
  get "/:username/videos", to: "videos#index", as: "videos"
  get "/:username/profile/edit", to: "users#edit", as: "edit_user"
  get "/:username/profile", to: "users#show", as: "user_show"
  get "/:username/stream", to: "users#stream", as: "user_stream"
  get "/:username/edit", to: "pages#edit", as: "edit_page"
  get "/:username", to: "pages#show", as: "page_show"
  root to: "static_pages#index"



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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
