class SparklineSetting
  def self.[](name, project_id=nil)
    if project_id
      project_settings = settings[name.to_s + '-' + project_id.to_s]
    end

    if project_settings.blank?
      project_settings = settings[name.to_s]
    end

    return project_settings
  end

  def self.x_axis_min_options
    {
      offset: I18n.t('sparkline_settings.offset'),
      issue_created: I18n.t('sparkline_settings.issue_created')
    }
  end

  def self.x_axis_max_options
    {
      today:  I18n.t('sparkline_settings.today'),
      issue_due:  I18n.t('sparkline_settings.issue_due')
    }
  end

  private

  def self.settings
    Setting[:plugin_sparkline].blank? ? {} : Setting[:plugin_sparkline]
  end
end
