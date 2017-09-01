Rails.application.routes.default_url_options = {
  host: ENV['APPLICATION_HOST']
}

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  mount Sidekiq::Web => '/queue'

  # User root, used by devise
  get '/user_root', to: redirect('/boards'), as: :user_root

  resources :boards, only: [:index, :show, :new, :create] do
    get 'update_violations', on: :member
  end

  resources :board_laws, only: [:new, :create]

  get 'trello/connect'
  get 'trello/connected'
  get 'trello/callback/:board_id' => 'trello#callback', as: :trello_callback
  post 'trello/callback/:board_id' => 'trello#callback'

  scope path: '/api', defaults: { format: 'json' } do
    api_version(module: "Api::V1", header: { name: "Accept", value: "version=1" }, default: true) do
      resources :cards, only: [] do
        resources :violations, only: [:index]
      end
    end
  end

  ActiveAdmin.routes(self)
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
