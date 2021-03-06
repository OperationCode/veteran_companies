Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  #Admin Routes
  mount Adminsimple::Engine => '/admin'
  scope '/admin' do
    devise_for :admins, path: '',
      skip: [:registrations, :confirmations],
      controllers: {sessions: 'adminsimple/devise/sessions', passwords: 'adminsimple/devise/passwords'}
    devise_scope :admin do
      resource :registration, only: [:edit, :update], path: 'profile', controller: 'adminsimple/devise/registrations', as: :admin_registration
    end
  end

  namespace :admin do
    resources :companies do
      member do
        put :publish
        put :take_offline
      end
    end
    resources :leaders
    resources :organizations
  end

  root 'home#show'

  resources :companies
  resources :leaders

  get '/mission' => 'mission#show'
  get '/research' => 'research#show'
  get '/infographic' => 'research#infographic'

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
