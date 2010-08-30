#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'


### install a bunch of utils
%w(rlwrap node coffee-script npm rlwrap kiwi).each do |pkg|
  homebrew pkg
end

script "configuring ndistro" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    cd #{ENV['HOME']}/Developer/bin

    curl -# -L http://github.com/visionmedia/ndistro/raw/master/bin/ndistro > ndistro 2> ~/.cider.log
    chmod 0755 ndistro
  EOS
end
