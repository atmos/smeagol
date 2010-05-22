#
# Cookbook Name:: rvm
# Recipe:: default
#

execute "install rvm to system gems" do
  command "gem install rvm --no-rdoc --no-ri"
end

execute "install rvm for the user" do
  command "rvm-install"
  not_if "test -d ~/.rvm"
end

script "installing rubinius and ruby 1.8.7 for the user" do
  interpreter "bash"
  code <<-EOS
    source ~/.profile
    rvm install rbx
  EOS
end

script "installing the bundler" do
  interpreter "bash"
  code <<-EOS
    source ~/.profile
    gem install bundler --no-rdoc --no-ri
    gem install bundler08 --no-rdoc --no-ri
  EOS
end
