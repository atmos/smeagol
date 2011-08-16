#
# Cookbook Name:: mvim
# Recipe:: cli
#

template "#{ENV['HOME']}/Developer/bin/mvim" do
  mode "0555"
  source "mvim"
end
