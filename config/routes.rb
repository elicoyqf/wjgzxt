Wjgzxt::Application.routes.draw do
  match 'workorders' => 'workorders#index'

  resources :workorders, only: [] do
    collection do
      get 'index', 'day_wo', 'week_wo', 'month_wo','wo_table'
    end
  end

  #get 'web_hit_rate/time_r'
  #get 'web_hit_rate/select_day_report'
  #get 'web_hit_rate/select_month_report'
  #
  #post 'web_hit_rate/day_r'
  #get 'web_hit_rate/day_r'
  #
  #post 'web_hit_rate/month_r'
  #get 'web_hit_rate/month_r'
  #
  #get 'web_hit_rate/index'

  resources :web_hit_rate, only: [] do
    collection do
      get 'time_r', 'select_day_report', 'select_month_report', 'index', 'day_r', 'month_r', 'list_day', 'list_time', 'list_locale'
      post 'day_r', 'month_r'
    end
  end

  match 'whr/' => 'web_hit_rate#index'

  get 'param_setting/http'

  get 'param_setting/ping'

  get 'param_setting/route'

  get 'param_setting/video'

  resources :reports, only: [] do
    collection do
      get 'export_rep'
      post 'day_report', 'week_report', 'month_report'
    end
  end

  get 'reports/time_report'

  get 'reports/select_date_report'

  post 'reports/date2time_report'

  get 'reports/day_report'

  get 'reports/week_report'

  get 'reports/export_ranking'

  post 'reports/website_ranking'

  get 'reports/website_select'

  get 'reports/locale_ranking'

  get 'welcome/index'

  match 'reports/' => 'reports#index'

  #match 'reports/export_ranking/:id' => 'reports#export_ranking'

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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
