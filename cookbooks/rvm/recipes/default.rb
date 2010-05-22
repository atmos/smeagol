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

script "install rvm for the user" do
  interpreter "bash"
  code "source ~/.profile; rvm install 1.8.7-p173"
end
