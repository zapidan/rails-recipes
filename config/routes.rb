Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  get '/home',              to: 'pages#home'

  # get '/recipes',           to: 'recipes#index'
  # get '/recipes/new',       to: 'recipes#new' , as: 'new_recipe'
  # post '/recipes',          to: 'recipes#create'
  # get '/recipes/:id/edit',  to: 'recipes#edit', as: 'edit_recipe'
  # patch '/recipes/:id',     to: 'recipes#update'
  # get '/recipes/:id',       to: 'recipes#show', as: 'recipe'
  # delete '/recipes/:id',     to: 'recipes#destroy'

  resources :recipes do
    member do 
      post 'like'
    end
    resources :reviews, only: [:create, :destroy]
  end

  # alias to recipes#show from reviews in case there is a page refresh
  get '/recipes/:id//reviews', to: 'recipes#show'

  resources :chefs, except: [:new, :destroy]

  get '/register', to: 'chefs#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :styles, only: [:new, :create, :show, :destroy]
  resources :ingredients, only: [:new, :create, :show, :destroy]


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
