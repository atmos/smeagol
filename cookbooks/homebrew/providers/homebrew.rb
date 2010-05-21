require 'pp'
require 'chef/provider'

class Chef
  class Provider
    class Package
      class Homebrew < ::Chef::Provider::Package
        HOMEBREW = "/usr/local/bin/brew"

        def latest_version_for(name)
          %x{#{HOMEBREW} info #{name}| head -n1 | awk '{print $2}'}.chomp
        end

        def load_current_resource
          @current_resource = Chef::Resource::Homebrew.new(@new_resource.name)
          @current_resource.package_name(@new_resource.name)
          @candidate_version = latest_version_for(@new_resource.name)
          @current_resource
        end

        def install_package(name, version)
          run_brew_command("#{HOMEBREW} install #{name}")
        end

        def remove_package(name, version)
          run_brew_command("#{HOMEBREW} uninstall #{name}")
        end

        def run_brew_command(command)
          Chef::Log.debug(command)
          run_command_with_systems_locale(
            :command => command
          )
        end
      end
    end
  end
end
