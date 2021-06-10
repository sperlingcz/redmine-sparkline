Redmine::Plugin.register :sparkline do
  name 'Sparkline plugin'
  author 'Sperling'
  description 'Sparkline plugin for done ratio of issues'
  version '1.0.0'
  url 'https://www.sperling.cz/redmine'
  author_url 'https://www.sperling.cz/redmine'

  require_dependency 'sparkline_hook_listener'

  project_module :sparkline do
    settings default: {
      x_min: "offset",
      x_max: "today",
      time_offset: 7,
      line_color: "blue",
      fill_color: "skyblue",
    }, partial: 'settings/sparkline/sparkline'
     permission :sparkline, {
      # settings: [ :plugin ]
     }
  end

end
