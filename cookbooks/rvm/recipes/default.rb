#
# Cookbook Name:: rvm
# Recipe:: default
#

execute "install rvm to system gems" do
  command "sudo gem install rvm --no-rdoc --no-ri"
end

execute "install rvm for the user" do
  command "rvm-install"
end

# this should really install rbx as the default
script "installing rubinius and ruby 1.8.7 for the user" do
  interpreter "bash"
  code <<-EOS
    source ~/.profile
    rvm install rbx
  EOS
end
