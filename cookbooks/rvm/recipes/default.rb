#
# Cookbook Name:: rvm
# Recipe:: default
#

execute "install rvm for the user" do
  command "rvm-install"
  not_if  "test -d ~/.rvm"
end

script "installing rubinius and ruby 1.8.7 for the user" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    rvm install rbx
  EOS
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

#script "installing the bundler" do
  #interpreter "bash"
  #code <<-EOS
    #source ~/.cider.profile
    #gem install bundler --no-rdoc --no-ri
    #gem install bundler08 --no-rdoc --no-ri
  #EOS
#end

#script "installing cider into rvm environment" do
  #interpreter "bash"
  #code <<-EOS
    #source ~/.cider.profile
    #gem install cider --no-rdoc --no-ri
  #EOS
#end
