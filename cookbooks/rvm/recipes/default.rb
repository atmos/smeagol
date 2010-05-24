#
# Cookbook Name:: rvm
# Recipe:: default
#

execute "install rvm for the user" do
  command "rvm-install"
  not_if  "test -d ~/.rvm"
end

script "installing ruby" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `rvm rbx -S ruby --version | grep rbx | head -n1 | grep -q "not installed"`
    if [ $? -eq 0 ]; then
      rvm install rbx
      rvm use ruby-1.8.7-p249 --default
    fi
  EOS
end

script "updating rvm to the latest stable version" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    rvm update -—head
  EOS
end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

gem_package "bundler" do
  version "0.9.25"
  gem_binary "#{ENV['HOME']}/.rvm/rubies/ruby-1.8.7-p249/bin/gem"
end

gem_package "bundler08" do
  version "0.8.5"
  gem_binary "#{ENV['HOME']}/.rvm/rubies/ruby-1.8.7-p249/bin/gem"
end

gem_package "cider" do
  version "0.1.2"
  gem_binary "#{ENV['HOME']}/.rvm/rubies/ruby-1.8.7-p249/bin/gem"
end
