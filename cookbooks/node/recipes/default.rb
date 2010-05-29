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

### Installing npm is kinda painful, homebrew recipe coming soon
npm_executable = "#{ENV['HOME']}/Developer/bin/npm"

file npm_executable do
  owner  ENV['USER']
  group  "staff"
  mode   "0755"
  action :create
end

template npm_executable do
  source "npm.erb"
end

directory "setup npm install directory" do
  mode      "0755"
  path      "#{ENV['HOME']}/Developer/Cellar/npm/src"
  group     "staff"
  owner     ENV['USER']
  recursive true
end

execute "installing npm" do
  command "git clone --depth 1 git://github.com/isaacs/npm.git .; make install-stable > ~/foo.log 2>&1"
  cwd     "#{ENV['HOME']}/Developer/Cellar/npm/src"
  path    [ "#{ENV['HOME']}/Developer/bin", "/usr/bin" ]
  not_if  "test -e #{ENV['HOME']}/Developer/Cellar/npm/src/cli.js"
end

execute "updating npm" do
  command "git pull && make install-stable > ~/foo.log 2>&1"
  cwd     "#{ENV['HOME']}/Developer/Cellar/npm/src"
  path    [ "#{ENV['HOME']}/Developer/bin", "/usr/bin" ]
  only_if  "test -e #{ENV['HOME']}/Developer/Cellar/npm/src/cli.js"
end
