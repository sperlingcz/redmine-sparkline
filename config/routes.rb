# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

# match 'settings/plugin/:id', :controller => 'sparkline_settings', :action => 'plugin_project', :via => [:get, :post], :as => 'plugin_settings'
# match 'sparkline_settings/plugin_project', :controller => 'sparkline_settings', :action => 'plugin_project', :via => [:get, :post], :as => 'plugin_settings'
# match 'settings/plugin(/:project_id)', :controller => 'settings', :action => 'plugin', :via => [:get, :post], :as => 'plugin_settings_witproject'

match 'projects/:project_id/settings(/:tab)', :controller => 'projects', :action => 'settings', :via => [:get, :post], :as => 'plugin_settings_project'
