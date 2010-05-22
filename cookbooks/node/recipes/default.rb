#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

### install a bunch of utils
%w(rlwrap node rlwrap kiwi).each do |pkg|
  homebrew pkg
end

#execute "fetch the latest npm" do
  #command "http://github.com/isaacs/npm/tarball/master"
#end
