module SettingsControllerPatch
  def self.included(base)
    # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)
    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development    , :authorize

       # before_action :find_project, :authorize, :only => [:plugin], unless: -> { params[:project_id].blank? }
      before_action :find_project, :only => [:plugin], unless: -> { params[:project_id].blank? }

      alias_method :old_plugin, :plugin
      alias_method :plugin, :new_plugin
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def new_plugin
      # unless
      unless params[:id] == :sparkline
        return old_plugin
      end
      @plugin = Redmine::Plugin.find(params[:id])

      unless @plugin.configurable?
        render_404
        return
      end

      if request.post?
        setting = params[:settings] ? params[:settings].permit!.to_h : {}
        orig_setting = Setting.send "plugin_#{@plugin.id}"
        orig_setting = orig_setting.merge!(setting) { |key, old, new| new }
        Setting.send "plugin_#{@plugin.id.to_s}=", orig_setting
        flash[:notice] = l(:notice_successful_update)
        if @project.blank?
          redirect_to plugin_settings_path
        else
          redirect_to plugin_settings_project_path(@project.identifier, @plugin.id)
        end
      else
        @partial = @plugin.settings[:partial]
        @settings = Setting.send "plugin_#{@plugin.id}"
      end
    rescue Redmine::PluginNotFound
      render_404
    end

    def find_project
      # @project variable must be set before calling the authorize filter
      @project = Project.find(params[:project_id]) unless params[:project_id].blank?
      params[:id] = :sparkline
    end
  end
end


unless SettingsController.included_modules.include? SettingsControllerPatch
  SettingsController.send(:include, SettingsControllerPatch)
end