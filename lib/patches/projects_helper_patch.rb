# frozen_string_literal: true

# Redmine - project management software
# Copyright (C) 2006-2019  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


module ProjectsHelperPatch
  def self.included(base)
    # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)
    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method :project_settings_tabs_without_sparkline, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_sparkline
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def project_settings_tabs_with_sparkline
      tabs = project_settings_tabs_without_sparkline
      if @project.enabled_module(:sparkline)
        tabs.push ( {:name => 'sparkline', :action => :sparkline, :partial => 'settings/plugin_sparkline', :label => :sparkline})
      end
      tabs
    end
  end
end



unless ProjectsHelper.included_modules.include? ProjectsHelperPatch
  ProjectsHelper.send(:include, ProjectsHelperPatch)
end
