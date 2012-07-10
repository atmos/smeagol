#
# Cookbook Name:: homebrew
# Recipe:: dbs
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

%w(ack xz coreutils imagemagick sqlite wget fortune markdown ctags-exuberant gpgme icu4c wget libyaml zeromq).each do |pkg|
  homebrew pkg
end

homebrew "tmux"
template "#{ENV['HOME']}/.tmux.conf" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.tmux.conf.erb"
  variables({ :home => ENV['HOME'] })
end

