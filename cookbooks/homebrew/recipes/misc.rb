#
# Cookbook Name:: homebrew
# Recipe:: dbs
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

%w(tig ack coreutils imagemagick sqlite gist wget hub fortune proctools markdown ctags-exuberant).each do |pkg|
  homebrew pkg
end


file "#{ENV['HOME']}/Developer/bin/brew-services" do
  mode   "0755"
  action :create
  content open("https://gist.github.com/raw/766293/75a7907004bbff0eb3b072d1d951be2cfe7e5020/brew-services.rb").read
end
