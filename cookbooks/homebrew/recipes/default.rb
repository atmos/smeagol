#
# Cookbook Name:: homebrew
# Recipe:: Mac OSX Bootstrapper
#
root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

script "setup /usr/local" do
  interpreter 'bash'
  code <<-EOS
    sudo mkdir -p /usr/local
    sudo chown -R #{ENV['USER']}:staff /usr/local
EOS
  not_if  "test -d /usr/local"
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  cwd '/usr/local'
  not_if "test -e /usr/local/bin/brew"
end

template "#{ENV['HOME']}/.bashrc" do
  mode   0700
  owner  ENV['USER']
  group  'staff'
  source "dot.bashrc.erb"
end

template "#{ENV['HOME']}/.profile" do
  mode   0700
  owner  ENV['USER']
  group  'staff'
  source "dot.profile.erb"
  variables({
    :home        => ENV['HOME'],
    :rvm_default => ENV['DEFAULT_RVM_VM'] || '1.8.7-p249'
  })
end

homebrew "git"
execute "update to the latest homebrew from github" do
  command "brew update"
end

homebrew_db "mongodb"
homebrew_db "postgresql"
homebrew_db "mysql"

### install a bunch of utils
%w(ack sqlite wget fortune).each do |pkg|
  homebrew pkg
end
