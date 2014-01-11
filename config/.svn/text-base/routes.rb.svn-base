PpPricing::Application.routes.draw do

  root :to => "products#index"

  resource :sessions, :only=> [:new, :create] do
    collection do
      get 'logout'
    end
  end

  resources :rate_results
  resources :rate_determinants
  resources :price_plans, :constraints => { :id => /.*/ }
  resources :services, :only => [:index, :edit]
  resources :zonal_coverages
  resources :tariff_tier_tapers, :constraints => { :id => /.*/ }
  resources :tariff_zones, :constraints => { :id => /.*/ }
  resources :general_code_items, :only => [:show]
  resources :pricing_structures, :only => [:edit]
  resources :service_characteristics, :only => [:index, :edit]
  resources :promotions, :only => [:index, :edit]
  resources :event_creation_templates, :only => [:index, :edit], :constraints => { :id => /.*/ }

  resources :templates do
    get :select_rate_determinants
    get :select_rate_results
    post :update_with_rates
    post :approve
    resources :rates
  end

  resources :tariff_model_areas, :constraints => { :id => /.*/ } do
    get :approve
    get :revert
    collection do
      post :calculation_options
      post :tmes
    end
  end

  resources :products, :only => [:index, :edit] do
    collection do
      get :synchronize
    end
  end

  resources :rate_tables, :except=> [:update] do
    post :update # changing the default `put update` to a post for use with x-editable
    resources :rate_rows, :only => [:index]
    post :show
  end

  resource :tools, :only=> [:index] do
     collection do
       get 'upload'
     end 
  end 

end
