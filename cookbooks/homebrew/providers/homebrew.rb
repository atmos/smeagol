require 'pp'
require 'chef/provider'

class Chef
  class Provider
    class Package
      class Homebrew < ::Chef::Provider::Package
        PREFIX   = "#{ENV['HOME']}/Developer"
        HOMEBREW = "#{PREFIX}/bin/brew"

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
          run_brew_command("#{HOMEBREW} info #{name} | grep -q \"Not installed\"; if [ $? -eq 0 ]; then /usr/bin/env HOMEBREW_TEMP=#{PREFIX}/tmp #{HOMEBREW} install #{name}; fi")
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
            "redis"      => "io.redis.redis-server.plist",
            "mongodb"    => "org.mongodb.mongod.plist",
            "memcached"  => "com.danga.memcached.plist",
            "postgresql" => "org.postgresql.postgres.plist" }[name]
        end

        def plist_fullpath_for(name)
          "#{PREFIX}/Cellar/#{name}/#{latest_version_for(name)}/#{plist_for(name)}"
        end

        def load_plist_for(name)
          Chef::Log.info("Configuring #{name} to automatically start on login")
          destination_plist = "#{ENV['HOME']}/Library/LaunchAgents/#{plist_for(name)}"
          system("mkdir -p #{ENV['HOME']}/Library/LaunchAgents")
          system("launchctl unload -w -F #{destination_plist} >/dev/null 2>&1")
          system("cp -f #{plist_fullpath_for(name)} #{destination_plist} >/dev/null 2>&1")
          system("launchctl load -w -F #{destination_plist} >/dev/null 2>&1")
        end

        def install_package(name, version)
          super(name, version)
          case name
          when "mongodb", "memcached", "redis"
          when "postgresql"
            unless ::File.directory?("#{PREFIX}/var/postgres")
              system("#{PREFIX}/bin/initdb #{PREFIX}/var/postgres > /dev/null 2>&1")
            end
          when "mysql"
            unless ::File.directory?("#{PREFIX}/var/mysql/mysql")
              prefix = `#{PREFIX}/bin/brew --prefix mysql`.chomp
              system("unset TMPDIR; #{PREFIX}/bin/mysql_install_db --user=#{ENV['USER']} --basedir=#{prefix} --datadir=#{PREFIX}/var/mysql --tmpdir=/tmp > /dev/null")
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
