#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

### install a bunch of utils
%w(rlwrap node rlwrap kiwi).each do |pkg|
  homebrew pkg
end

### Installing npm is kinda painful
npm_executable = "#{ENV['HOME']}/Developer/bin/npm"
file npm_executable do
  owner ENV['USER']
  group "staff"
  mode "0755"
  action :create
end

template npm_executable do
  source "npm.erb"
end

directory "#{ENV['HOME']}/Developer/Cellar/npm" do
  owner ENV['USER']
  group "staff"
  mode "0755"
end

execute "fetching latest stable npm release" do
  command "curl -L http://github.com/isaacs/npm/tarball/master | tar xz --strip 1; make"
  cwd "#{ENV['HOME']}/Developer/Cellar/npm"
end
