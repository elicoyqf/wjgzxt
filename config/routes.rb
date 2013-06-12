Wjgzxt::Application.routes.draw do
  match 'log' => 'log_action#index'
  match 'log(/:action)' => 'log_action#(:action)'
  resources :log_action,only:[:index] do
    collection do
      get 'index','neg_r','neg_ru'
    end
  end

  resources :pwd_modify, only: [] do
    collection do
      get 'modify', 'p_modify'
    end
  end

  resources :domain, only: [] do
    collection do
      get 'validate', 'test', 'dfileupload'
      post 'upload'
    end
  end

  resources :export, only: [] do
    member do
      get 'modify', 'chg_status', 'del'
    end
    collection do
      get 'index', 'flag', 'perm_deni'
      get 'mdf', 'add_flag', 'p_add_flag'
    end
  end

  resources :rdata, only: [] do
    collection do
      get 'index','q_rdata_report'
    end
  end

  match 'login' => 'login#index'
  get 'login/index'
  post "login/login"
  get "login/logout"

  match 'workorders' => 'workorders#index'
  resources :workorders, only: [] do
    collection do
      get 'index', 'day_wo', 'week_wo', 'month_wo', 'wo_table', 'export_detail', 'week_table', 'month_table'
    end
  end

  match 'graphs' => 'graphs#index'
  resources :graphs, only: [] do
    collection do
      get 'index', 'data_json'
    end
  end

  resources :web_hit_rate, only: [] do
    collection do
      get 'time_r', 'select_day_report', 'select_month_report', 'index', 'day_r', 'month_r', 'list_day', 'list_time', 'list_locale'
      post 'day_r', 'month_r'
    end
  end

  match 'whr/' => 'web_hit_rate#index'

  resources :param_setting, only: [] do
    collection do
      get 'http', 'ping', 'route', 'video', 'adduser', 'mng_user', 'interaction', 'view_interaction', 'del_interaction', 'p_adduser'
      get 'u_user', 's_user', 'd_user', 'p_u_user', 'p_interaction'
      post 'p_adduser'
    end
  end

  match 'reports/get_data(.:format)' => 'reports#get_data'
  resources :reports, only: [] do
    collection do
      get 'export_rep', 'get_data', 'r_graph', 'locale_detail'
      get 'select_date_report', 'select_day_report', 'select_week_report', 'select_month_report'
      get 'time_report', 'day_report', 'week_report', 'month_report', 'day_report_csv', 'week_report_csv', 'month_report_csv'
      get 'date2time_report', 'date2day_report', 'date2week_report', 'date2month_report'
      post 'day_report', 'week_report', 'month_report'
    end
  end

  get 'reports/export_ranking'

  post 'reports/website_ranking'

  get 'reports/website_select'

  get 'reports/locale_ranking'

  get 'welcome/index'

  match 'reports/' => 'reports#index'
  match 'welcome/' => 'welcome#index'

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
  root :to => 'login#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
