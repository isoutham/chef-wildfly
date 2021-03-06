# encoding: UTF-8
#
# rubocop:disable LineLength, SpecialGlobalVars, MethodLength
require 'etc'

# Support whyrun
def whyrun_supported?
  true
end

action :set do
  if property_value_exists?
    Chef::Log.info "#{ @new_resource } already set - nothing to do."
  else
    converge_by("Set #{ @new_resource }") do
      property_set
    end
    notify?
  end
end

action :delete do
  if property_exists?
    converge_by("Delete #{ @new_resource }") do
      property_delete
    end
    notify?
  else
    Chef::Log.info "#{ @new_resource } not present - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::WildflyProperty.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.property(@new_resource.property)
  @current_resource.value(@new_resource.value)
  @current_resource.restart(@new_resource.restart)
end

private

def notify?
  # Only notify if restart parameter is true
  if @current_resource.restart
    @new_resource.updated_by_last_action(true)
  else
    @new_resource.updated_by_last_action(false)
  end
end

def property_value_exists?
  `su #{node['wildfly']['user']} -c "#{node['wildfly']['base']}/bin/jboss-cli.sh -c '/system-property=#{current_resource.property}:read-attribute(name=value)'"`.include? " \"#{current_resource.value}\""
end

def property_exists?
  `su #{node['wildfly']['user']} -c "#{node['wildfly']['base']}/bin/jboss-cli.sh -c '/system-property=#{current_resource.property}:read-resource' >/dev/null"`
  $?.exitstatus == 0
end

def property_set
  bash 'property_set' do
    user node['wildfly']['user']
    cwd node['wildfly']['base']
    code <<-EOH
      if $(bin/jboss-cli.sh -c '/system-property=#{current_resource.property}:read-resource' >/dev/null); then
        bin/jboss-cli.sh -c "/system-property=#{current_resource.property}:write-attribute(name=value,value=#{current_resource.value})"
      else
        bin/jboss-cli.sh -c "/system-property=#{current_resource.property}:add(value=#{current_resource.value})"
      fi
    EOH
  end
end

def property_delete
  bash 'property_delete' do
    user node['wildfly']['user']
    cwd node['wildfly']['base']
    code <<-EOH
      bin/jboss-cli.sh -c "/system-property=#{current_resource.property}:remove()"
    EOH
  end
end