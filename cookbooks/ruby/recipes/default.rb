#
# Cookbook Name:: ruby
# Recipe:: default
#

template "#{ENV['HOME']}/.irbrc" do
  source "dot.irbrc.erb"
end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

template "#{ENV['HOME']}/.rdebugrc" do
  source "dot.rdebugrc.erb"
end
