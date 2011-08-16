#
# Cookbook Name:: mvim
# Recipe:: cli
#

template "#{ENV['HOME']}/Developer/bin/mvim" do
  source "mvim"
end
