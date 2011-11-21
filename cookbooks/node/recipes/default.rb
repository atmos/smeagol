#
# Cookbook Name:: node
# Recipe:: default
#
#
#
DEFAULT_NODE_VERSION = "v0.6.1"
SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

template "#{ENV['HOME']}/.npmrc" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.npmrc.erb"
  variables({ :home => ENV['HOME'] })
end

script "configuring nvm and node #{DEFAULT_NODE_VERSION}" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    cd #{SMEAGOL_ROOT_DIR}
    if [ ! -d ./.nvm ]; then
      git clone git://github.com/creationix/nvm.git .nvm >> ~/.cinderella/node.log
      source #{SMEAGOL_ROOT_DIR}/.nvm/nvm.sh        >> ~/.cinderella/node.log
      nvm install #{DEFAULT_NODE_VERSION}                >> ~/.cinderella/node.log
      nvm alias default #{DEFAULT_NODE_VERSION}          >> ~/.cinderella/node.log
      curl http://npmjs.org/install.sh | clean=yes sh    >> ~/.cinderella/node.log
    fi
  EOS
end
