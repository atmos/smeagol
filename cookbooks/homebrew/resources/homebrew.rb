require 'chef/resource/script'

class Chef
  class Resource
    class Homebrew < ::Chef::Resource::Package
      def initialize(name, collection = nil, node = nil)
        super(name, collection, node)
        @resource_name = :homebrew
        @provider      = Chef::Provider::Package::Homebrew
        @allowed_actions = [ :install, :remove ]
      end
    end
  end
end
