require 'redmine'
require 'dispatcher' unless defined? ActionDispatch

dispatcher = if defined? ActionDispatch then ActionDispatch::Callbacks else Dispatcher end

dispatcher.to_prepare do
  Project.send(:include, RedmineDefaultVersion::Patches::ProjectPatch) unless Project.include?(RedmineDefaultVersion::Patches::ProjectPatch)
  ProjectsHelper.send(:include, RedmineDefaultVersion::Patches::ProjectsHelperPatch) unless ProjectsHelper.include?(RedmineDefaultVersion::Patches::ProjectsHelperPatch)
end

Redmine::Plugin.register :redmine_default_version do
  name 'Redmine Default Version Plugin'
  author 'Tony Marschall, Undev'
  description 'This plugin enables you to specify a default project version.'
  version '1.0.0'
  url ' https://github.com/Undev/redmine_default_version'
end

require_dependency 'redmine_default_version/hooks/view_projects_form_hook'
