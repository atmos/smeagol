#
# Cookbook Name:: homebrew
# Recipe:: dbs
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

%w(tig ack sqlite wget fortune proctools markdown ctags-exuberant).each do |pkg|
  homebrew pkg
end
