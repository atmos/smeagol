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

      class HomebrewDb < Homebrew
        def plist_for(name)
          { "mysql"      => "com.mysql.mysqld.plist",
            "mongodb"    => "org.mongodb.mongod.plist",
            "postgresql" => "org.postgresql.postgres.plist" }[name]
        end

        def plist_fullpath_for(name)
          "/usr/local/Cellar/#{name}/#{latest_version_for(name)}/#{plist_for(name)}"
        end

        def load_plist_for(name)
          Chef::Log.info("Configuring #{name} to automatically start on login")
          destination_plist = "#{ENV['HOME']}/Library/LaunchAgents/#{plist_for(name)}"
          unless ::File.exist?(destination_plist)
            system("cp #{plist_fullpath_for(name)} #{destination_plist}/")
            system("launchctl load -w #{destination_plist}")
          end
        end

        def install_package(name, version)
          super(name, version)
          case name
          when "mongodb"
          when "postgresql"
            unless ::File.directory?("/usr/local/var/postgres")
              run_command("initdb /usr/local/var/postgres")
            end
          when "mysql"
            unless ::File.directory?("/usr/local/var/mysql")
              run_command("/usr/local/Cellar/mysql/#{latest_version_for(name)}/bin/mysql_install_db")
            end
          else
            raise "Unknown Homebrew DB: #{name}"
          end
          load_plist_for(name)
        end
      end
    end
  end
end
