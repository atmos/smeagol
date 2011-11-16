#
# Cookbook Name:: mvim
# Recipe:: cli
#

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

template "#{SMEAGOL_ROOT_DIR}/bin/mvim" do
  mode "0555"
  source "mvim"
end
